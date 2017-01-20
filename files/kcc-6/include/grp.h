#ifndef _GRP_INCLUDED
#define _GRP_INCLUDED
#ifndef __STDC__	/* Canonicalize this indicator to avoid err msgs */
#define __STDC__ 0
#endif

struct	group { /* see getgrent(3) */
	char	*gr_name;
	char	*gr_passwd;
	int	gr_gid;
	char	**gr_mem;
};

#pragma private define setgroupent setgrn

#if __STDC__
extern struct group *getgrent(void);
extern struct group *getgrgid(int);
extern struct group *getgrnam(const char*);
extern void setgroupent(int stayopen);
extern void setgrent(void);
extern void endgrent(void);
#else
struct group *getgrent(), *getgrgid(), *getgrnam();
void setgroupent(), setgrent(), endgrent();
#endif

#endif /* ifndef _GRP_INCLUDED */
