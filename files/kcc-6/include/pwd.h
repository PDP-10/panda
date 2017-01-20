/* <PWD.H> - definitions to support getpw*() functions
**
**	(c) Copyright Ken Harrenstien 1989
**
** Supports:	V7: getpw()
**		4.3BSD: getpwuid()
**		4.3BSD: getpwnam()
** as per 4.3BSD documentation.
**	Note: getpwent, setpwent, endpwent and setpwfile are unsupported.
**	Those are primarily system maintenance functions anyway.
*/

#ifndef _PWD_INCLUDED
#define _PWD_INCLUDED

struct passwd {			/* Unspecified components (-) are NULL or 0 */
	char *pw_name;		/* T20: user name */
	char *pw_passwd;	/* - */
	int pw_uid;		/* T20: user number */
	int pw_gid;		/* - */
	int pw_quota;		/* - */
	char *pw_comment;	/* - */
	char *pw_gecos;		/* - (!!) */
	char *pw_dir;		/* T20: user directory path, "dev:<dir>" */
	char *pw_shell;		/* T20: "SYSTEM:EXEC.EXE" */
};

#ifdef __STDC__
int getpw(int uid, char *buf);
struct passwd *getpwuid(int uid), *getpwnam(char *name), *getpwent(void);
void setpassent(int stayopen);
void setpwent(void);
void endpwent(void);
#else
int getpw();
struct passwd *getpwuid(), *getpwnam(), *getpwent();
void setpassent(), setpwent(), endpwent();
#endif

#endif /* ifndef _PWD_INCLUDED */
