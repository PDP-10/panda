/*
 *	test different buffering types
 */

#include "stdio.h"

main()
{
    fputs("Testing different buffering types.\n\n", stderr);
    fputs("Note that this output is going to stderr, which is unbuffered\n", stderr);
    fputs("to begin with.  Setting stdout to unbuffered.\n", stderr);
    setvbuf(stdout, NULL, _IONBF, 0);
    fputs("Each character (with 1 seconds sleep between them) should come\n", stderr);
    fputs("out independently.  Here goes:\n-----\n", stderr);
    putchar('1');
    sleep(1);
    putchar('2');
    sleep(1);
    putchar('3');
    sleep(1);
    putchar('4');
    sleep(1);
    putchar('5');
    fputs("\n-----\nOK, now here goes linebuffered mode.  Each line should come out\n", stderr);
    fputs("independently, with a second pause between them.  Setting linebuffer mode.\n", stderr);
    setvbuf(stdout, NULL, _IOLBF, BUFSIZ);	/* let it make the buf */
    fputs("OK, here goes:\n-----\n", stderr);
    puts("Mary had a little lamb");
    sleep(1);
    puts("Its niece was black as coal");
    sleep(1);
    puts("Every time it stayed out late");
    sleep(1);
    puts("She beat it mercilessly.");
    sleep(1);
    puts("The End.");
    fputs("\n-----\nOK, now for block buffered mode.  each line has a second pause\n", stderr);
    fputs("but you should just get one long wait and then all the lines at once\n", stderr);
    fputs("instead of one line at a time.   setting block buffer mode.\n", stderr);
    setvbuf(stdout, NULL, _IOFBF, BUFSIZ);
    fputs("Here goes:\n-----\n", stderr);
    puts("As I was walking down the street one day");
    sleep(1);
    puts("I saw a house on fire...");
    sleep(1);
    puts("There was a man");
    sleep(1);
    puts("Shouting & screaming from an upper-story window");
    sleep(1);
    puts("To the crowd that was gathered there below");
    sleep(1);
    puts("For he was so afraid.");
    fflush(stdout);
    fputs("-----\nEND OF TEST.\n", stderr);
}
