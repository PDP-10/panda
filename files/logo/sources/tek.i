/* Include file for turtle.c for TEK */

int tekfrom(),tekto(),tekin(),tekout(),tekstate();
struct display tek ={0.0,0.0,0.0,-512.0,511.0,-390.0,389.0,1.0,0,
	"","\032\035\033\014\030","","\032\035\033\014\030",
	nullfn,tekfrom,tekto,nullfn,tekin,tekout,nullfn,
	nullfn,nullfn,tekstate};

tekfrom(x,y)
double x,y;
{
	printf("\035");
	plotpos((int)x,(int)y);
}

tekto(x,y)
double x,y;
{
	plotpos((int)x,(int)y);
	printf("\035\067\177\040\100\037\030");
}

tekin() {
	shown = 0;
	system("stty -lcase");
}

tekout() {
	system("stty lcase");
}

tekstate(which) {
	switch(which) {
		case 'R':
			printf("Tek can't penreverse, setting pendown\n.");
			penerase = 0;
			return;
		case 'E':
			printf("Tek can't penerase, setting pendown.\n");
			penerase = 0;
			return;
		case 'S':
			printf("Tek can't showturtle.\n");
			shown = 0;
	}
}
