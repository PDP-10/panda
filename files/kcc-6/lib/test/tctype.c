/* Program to test out the character processing facilities
** (CARM section 11.1) -- the stuff in <ctype.h>.
*/

#include "ctype.h"
#include "stdio.h"

char blurb[] = "\
A - isalnum\n\
a - isalpha\n\
^ - iscntrl\n\
c - iscsym\n\
C - iscsymf\n\
D - isdigit\n\
G - isgraph\n\
L - islower\n\
O - isodigit\n\
P - isprint\n\
: - ispunct\n\
  - isspace\n\
U - isupper\n\
X - isxdigit\n";


char *showch();
main()
{
    int i;
    printf("Character facility test:\n\n%s\n", blurb);
    for(i = -3; i <= 130; ++i)
	check(i);
    check(EOF);
}

check(c)
int c;
{
    if (!isascii(c) && c != EOF) {
	printf("Non-ASCII char val %d, => ASCII ", c, c);
	c = toascii(c);
    }
    if (c == EOF) printf("Char val %4d  EOF: ", c);
    else printf("Char val %#4o %4s: ",c, showch(c));

#define test(macro,fch) putchar(macro(c) ? fch : '-')
	test(isalnum,'A');
	test(isalpha,'a');
	test(iscntrl,'^');
	test(iscsym, 'c');
	test(iscsymf,'C');
	test(isdigit,'D');
	test(isgraph,'G');
	test(islower,'L');
	test(isodigit,'O');
	test(isprint,'P');
	test(ispunct,':');
	test(isspace,' ');
	test(isupper,'U');
	test(isxdigit,'X');

	if(isxdigit(c))
	    printf(" I:%2d", toint(c));
	else if(-1 != toint(c))
	    printf(" (ERR: toint(c) => %d)", toint(c));

	if(islower(c))
	    printf(" U:%s", showch(toupper(c)));
	else if (c != toupper(c))
	    printf(" (ERR: toupper(c) => %s)", showch(toupper(c)));

	if(isupper(c))
	    printf(" L:%s", showch(tolower(c)));
	else if (c != tolower(c))
	    printf(" (ERR: tolower(c) => %s)", showch(tolower(c)));

	if (islower(c) && (_toupper(c) != toupper(c)))
	    printf(" (ERR: _toupper(c) => %s)", showch(_toupper(c)));
	if (isupper(c) && (_tolower(c) != tolower(c)))
	    printf(" (ERR: _tolower(c) => %s)", showch(_tolower(c)));

	printf("\n");
}

char *
showch(c)
int c;
{
    static char tmpstr[10];
    char *cp = tmpstr;

    if (isprint(c)) *cp = c;
    else if (c == EOF) return "EOF";
    else {
	*cp = '^';
	*++cp = (c==0177 ? '?' : (c&037)+('A'-1));
    }    
    *++cp = 0;
    return tmpstr;
}
