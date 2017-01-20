/* Include file for turtle.c for both ADM and TEK */

plotpos(x,y)
int x,y;
{
	char s[5];

	x += 512;
	y += 390;
	s[0] = 040 + ((y>>5)&037);
	s[1] = 0140 + (y&037);
	s[2] = 040 + ((x>>5)&037);
	s[3] = 0100 + (x&037);
	s[4] = 0;
	printf("%s",s);
}
