/* Test EXEC() call
*/

main(argc, argv)
int argc; char **argv;
{
	int ret;
	if (argc < 2)
		printf("Usage: texec <progname> <arg1> ... <argn>\n");
	else if (ret = execvp(argv[1], &argv[1]))
		printf("Failed, returned %d\n", ret);
}
