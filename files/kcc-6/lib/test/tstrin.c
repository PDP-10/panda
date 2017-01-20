/*
 *	test string lib functions
 */

#include "string.h"

char s1[] = "now is the time-for all good men!";
char s2[] = "t";
char s3[] = "";
char s4[] = "foo";
char s5[] = "ti";
char s6[] = "times";

main()
{
#if 0
    test1(s1, s2);
    test1(s1, s3);
    test1(s1, s4);
    test1(s1, s5);
    test1(s1, s6);
    test2();
    test3("1.0");
    test3("-1.0");
    test3("10.1");
    test3("-010.10101021");
    test3("0");
    test3(".");
    test3(".foo");
    test3(".0");
    test3("69bar");
    test3("e1");
    test3(".e-1");
    test3("3.1415e+6");
    test3("-9.9e-9");
    test3("");
    test3("9999999999999999999");
#endif
    test4("-1", 10);
    test4("0", 10);
    test4("ff", 16);
    test4("z", 36);
    test4("101", 2);
    test4("-101", 2);
    test4("1112", 2);
    test4("0", 0);
    test4("10", 0);
    test4("0377", 0);
    test4("0xfff", 0);
}

test1(s1, s2)
char *s1, *s2;
{
    char *p;

    printf("strstr(\"%s\", \"%s\") --> ", s1, s2);
    p = strstr(s1, s2);
    if (!p) puts("failed!");
    else printf("\"%s\"\n", p);
}

test2()
{
    char *p;
    int len;

    len = strlen(s1);
    strtok(s1, "- ");
    while (strtok(NULL, "- ")) ;
    p = s1;
    while (--len >= 0) {
	printf("%3o '%c'\n", *p, *p);
	*p++;
    }
}

test3(s1)
char *s1;
{
    double value;
    char *p;

    printf("strtod(\"%s\")\n", s1);
    value = strtod(s1, &p);
    printf("value = %g, rest = \"%s\"\n", value, p);
}

test4(s1, base)
char *s1;
int base;
{
    long val1;
    unsigned long val2;
    char *p;

    printf("strtol(\"%s\", %d) --> ", s1, base);
    val1 = strtol(s1, &p, base);
    printf("value = %ld, rest = \"%s\"\n", val1, p);
    printf("strtoul(\"%s\", %d) --> ", s1, base);
    val2 = strtoul(s1, &p, base);
    printf("value = %lu, rest = \"%s\"\n", val2, p);
}
