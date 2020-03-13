#include <sys/param.h>
extern char *getwd();
main()
{
    char *ret;
    char buf[MAXPATHLEN];

    buf[0] = 0;
    ret = getwd(buf);
    if (ret) printf("getwd won: \"%s\"\n", ret);
    else printf("getwd failed: \"%s\"\n", buf);
}
