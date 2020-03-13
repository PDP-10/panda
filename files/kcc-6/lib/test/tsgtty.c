/*
 *	test sgtty
 */

#include "stdio.h"
#include "sgtty.h"

main()
{
    struct sgttyb buf;

    gtty(fileno(stdin), &buf);		/* read current stuff */
    printf("input speed = %d\n", _tspeed(buf.sg_ispeed));
    printf("output speed = %d\n", _tspeed(buf.sg_ospeed));
    printf("erase char = '%c' = '\\%3o'\n", buf.sg_erase, buf.sg_erase);
    printf("kill char = '%c' = '\\%3o'\n", buf.sg_kill, buf.sg_kill);
    printf("flags = 0%o\n", buf.sg_flags);
    puts("turning off echo...\n");
    buf.sg_flags &= ~ECHO;
    stty(fileno(stdin), &buf);
    puts("OK, try typing a few chars, end with NL");
    while (getchar() != '\n') ;
    puts("OK, turning echo back on.");
    buf.sg_flags |= ECHO;
    stty(fileno(stdin), &buf);
    puts("OK, try typing a few chars, end with NL");
    while (getchar() != '\n') ;
    puts("OK, setting speed to 4800...");
    buf.sg_ispeed = buf.sg_ospeed = B4800;
    stty(fileno(stdin), &buf);
}

int _tspeed(speed)
char speed;
{
    switch (speed) {
	case B0: return 0;
	case B50: return 50;
	case B75: return 75;
	case B110: return 110;
	case B150: return 150;
	case B200: return 200;
	case B300: return 300;
	case B600: return 600;
	case B1200: return 1200;
	case B1800: return 1800;
	case B2400: return 2400;
	case B4800: return 4800;
	case B9600: return 9600;
	case B19200: return 19200;
	default: return -1;
    }
}
