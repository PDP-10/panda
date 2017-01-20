#include "logo.h"
#include <signal.h>

extern int nullfn();
extern int errrec();
extern int ehand2(),ehand3();
extern char *token();
extern char *getenv();
extern char titlebuf[],editfile[];
extern int letflag;
#ifndef NOTURTLE
extern int turtdes,textmode;
extern struct display *mydpy;
#endif
extern catfile();
extern t20save();
extern t20restore();

chkproc(str,prim,obj)
register char *str;
char *prim;
struct object *obj;
{
	register char ch;

	if (((ch = *str)<'a') || (ch>'z')) ungood(prim,obj);
	if (memb('/',str)) ungood(prim,obj);
	if (strlen(str)>NAMELEN) ungood(prim,obj);
}

stedit(ednobj,flag)
struct object *ednobj;
int flag;
{
	register char *edname;
	register struct object *rest;
	char fnam[40];
	char edline[100];
	FILDES edfd;

	if (ednobj==0) ungood("Edit",ednobj);
	if (flag==0) unlink(editfile);
	switch (ednobj->obtype) {
		case INT:
		case DUB:
			ungood("Edit",ednobj);
		case CONS:
			for (rest=ednobj; rest; rest=rest->obcdr)
				stedit(localize(rest->obcar),1);
			break;
		default: /* STRING */
			edname = token(ednobj->obstr);
			chkproc(edname,"Edit",ednobj);
			cpystr(fnam,edname,EXTEN,NULL);
			if ((edfd=open(fnam,READ,0))<0) {
				cpystr(fnam,"PS:<LOGO.LIBRARY>",edname,EXTEN,NULL);
				if ((edfd=open(fnam,READ,0)) < 0) {
					cpystr(fnam,edname,EXTEN,NULL);
					edfd = creat(fnam,0666);
					if (edfd < 0) {
						printf("Can't write %s.\n",edname);
						mfree(ednobj);
						errhand();
					}
					onintr(ehand3,edfd);
					write(edfd,"to ",3);
					write(edfd,edname,strlen(edname));
					write(edfd,"\n\nend\n",6);
				}
			}
			close(edfd);
			onintr(errrec,1);
			catfile(fnam,editfile);
	}
	mfree(ednobj);
	if (flag==0) doedit();
}

doedit() {
	register char ch,*cp;
	FILE *fd,*ofd;
	int i,pid,status;
	char *name,*envedit;
	char fname[30];
	char line[200];
	static char binname[25] = "";
	static char editname[20];
	static char *editor;

	t20save();
	editor = getenv("EDITOR");
	envedit = editor ? editor : EDT;	/* default editor */
	strcpy(binname,"SYS:");
	strcat(binname,envedit);
	strcpy(editname,envedit);

/* Hack for DEFINE EDITOR: SYS:FOO -- MRC */

	i = 0;
	while (binname[i] != '\0' && binname[i] != '.') ++i;
	if (binname[i] == '\0') {
		strcat(binname,".EXE");
		strcat(editname,".EXE");
	}

#ifndef NOTURTLE
	if (turtdes<0) {
		(*mydpy->state)('t');
		textmode++;
	}
#endif
	fflush(stdout);
	signal(SIGINT,SIG_IGN);
	signal(SIGQUIT,SIG_IGN);
	switch (pid=fork()) {
		case -1:
			t20restore();
			printf("Can't fork to editor.\n");
			errhand();
		case 0:
			if (editor) execl(editname,editname,editfile,0);
			/* Only try bare name if really user-specified. */
			execl(binname,editname,editfile,0);
			t20restore();
			printf("Can't find editor.\n");
			exit(2);
		default:
			while (wait(&status) != pid) ;
	}
	if (status&0177400) {
		t20restore();
		printf("Redefinition aborted.\n");
		errhand();
	}
	t20restore();
	if ((fd=fopen(editfile,"r"))==NULL) {
		t20restore();
		printf("Can't reread edits!\n");
		errhand();
	}
	onintr(ehand2,fd);
	while (fgets(line,200,fd)) {
		for (cp = line; (ch = *cp)==' ' || ch=='\t'; cp++) ;
		if (ch == '\n') continue;
		if (strcmp(token(cp),"to")) {
			printf("Edited file includes non-procedure.\n");
			ehand2(fd);
		}
		for (cp += 2; (ch = *cp)==' ' || ch=='\t'; cp++) ;
		name = token(cp);
		printf("Defining %s\n",name);
		sprintf(fname,"%s%s",name,EXTEN);
		ofd = fopen(fname,"w");
		if (ofd==NULL) {
			printf("Can't write %s\n",fname);
			ehand2(fd);
		}
		fprintf(ofd,"%s",line);
		while (fgets(line,200,fd)) {
			fprintf(ofd,"%s",line);
			for (cp = line; (ch = *cp)==' ' || ch=='\t'; cp++) ;
			if (!strcmp(token(cp),"end")) break;
		}
		fclose(ofd);
	}
	fclose(fd);
	onintr(errrec,1);
}

struct object *cmedit(arg)
struct object *arg;
{
	stedit(arg,0);
	return ((struct object *)(-1));
}

struct object *erase(name)	/* delete a procedure from directory */
register struct object *name;
{
	register struct object *rest;
	char temp[16];

	if (name==0) ungood("Erase",name);
	switch(name->obtype) {
		case STRING:
			cpystr(temp,name->obstr,EXTEN,NULL);
			if (unlink(temp)<0) {	/* undefined procedure */
				nputs("You haven't defined ");
				puts(name->obstr);
				errhand();
			}
			break;
		case CONS:
			for (rest = name; rest; rest = rest->obcdr)
				erase(localize(rest->obcar));
			break;
		default:	/* number */
			ungood("Erase",name);
	}
	mfree(name);
	return ((struct object *)(-1));
}

addlines(edfd)	/* read text of procedure, simple TO style */
int edfd;
{
	register char *lintem;
	int oldlet;
	static char tstack[IBUFSIZ];
	int brak,brace,ch;	/* BH 1/7/82 */

	oldlet=letflag;
	letflag=1;	/* read rest of line verbatim */
loop:
	putchar('>');
	fflush(stdout);
	lintem=tstack;
	brace = brak = 0;	/* BH 1/7/82 count square brackets */
	do {
		while ((ch=getchar())!='\n') {
			if (lintem >= &tstack[IBUFSIZ-2]) {
				printf("Line too long.");
				goto loop;
			}
			*lintem++ = ch;
			if (ch == '\\') *lintem++ = getchar();
			else if (ch == '[') brak++;
			else if (ch == ']') --brak;
			else if (brak == 0) {
				if (ch == '{' || ch == '(') brace++;
				else if (ch == '}' || ch == ')') --brace;
			}
		}
		if (brak > 0) {
			*lintem++ = ' ';
			printf("[: ");
			fflush(stdout);
		} else if (brace > 0) {
			*lintem++ = ' ';
			printf("{(: ");
			fflush(stdout);
		}
	} while (brace+brak > 0);
	*lintem++='\n';
	*lintem='\0';
	write(edfd,tstack,lintem-tstack);
	for (lintem = tstack; memb(*lintem++," \t") ; ) ;
	--lintem;
	if (strcmp(token(lintem),"end")) goto loop;
	letflag=oldlet;
	close(edfd);
}

struct object *show(nameob)
register struct object *nameob;
{
	register struct object *rest;
	register char *name;
	FILE *sbuf;
	char temp[100];

	if (nameob==0) ungood("Show",nameob);
	switch(nameob->obtype) {
		case STRING:
			name = nameob->obstr;
			cpystr(temp,name,EXTEN,NULL);
			if (!(sbuf=fopen(temp,"r"))) {
				cpystr(temp,"PS:<LOGO.LIBRARY>",name,EXTEN,NULL);
				if (!(sbuf = fopen(temp,"r"))) {
					printf("You haven't defined %s\n",name);
					errhand();
				}
			}
			onintr(ehand2,sbuf);
			while (putch(getc(sbuf))!=EOF)
				;
			fclose(sbuf);
			onintr(errrec,1);
			break;
		case CONS:
			for (rest = nameob; rest; rest = rest->obcdr) {
				show(localize(rest->obcar));
				putchar('\n');
			}
			break;
		default:	/* number */
			ungood("Show",nameob);
	}
	mfree(nameob);
	return ((struct object *)(-1));
}
