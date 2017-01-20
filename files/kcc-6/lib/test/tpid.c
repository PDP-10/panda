/* Test GETPID() */
int pid, wpid;
main()
{
	prtpid("Self PID is", getpid());
	pid = fork();
	if (pid == 0) {
		prtpid("Child PID is", getpid());
		exit(0);
	}	
	wpid = wait(0);
	prtpid("Child's PID in parent was", pid);
	prtpid("PID from wait() is       ", pid);
}

prtpid(s,p)
char *s;
int p;
{
	printf("%s %o,,%o\n", s, (unsigned)p>>18, p&0777777);
}