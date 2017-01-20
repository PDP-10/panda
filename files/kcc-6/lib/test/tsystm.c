#include <stdio.h>
main()
{
	char	testline[100];

    system("whois klh");
    system("host sri-nic");
    while (1) {
	printf("Enter test line: ");
	fgets(testline,99,stdin);
	*(testline+strlen(testline)-1) = 0;
	system(testline);
	printf("\nDone.\n");
    }
}
