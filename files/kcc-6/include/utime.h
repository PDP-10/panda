/* <UTIME.H> - utime() support */

#ifndef _UTIME_H
#define _UTIME_H

struct utimbuf {
  time_t actime;
  time_t modtime;
};

#ifdef __STDC__
extern int utime(const char *file, const struct utimbuf *timep);
#else
extern int utime();
#endif

#endif /* ifndef _UTIME_H */
