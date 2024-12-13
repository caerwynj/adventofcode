implement Command;
include "cmd.m";
main(argv:list of string)
{
	print("AoC 13.2\n");
	argv = tl argv;

	lines := getlines(hd argv);
	
	a,b,c,d, b1, b2, det, x1, x2: real;
	a = 94.0;
	b = 22.0;
	c = 34.0;
	d = 67.0;

	b1 = 8400.0;
	b2 = 5400.0;

	det = 1.0/(a*d - b*c);
	print("%g\n", det);

	x1 = det*d*b1 + det*-b*b2;
	x2 = det*-c*b1 + det*a*b2;
	print("%g %g | %d %d \n", x1, x2, int x1, int x2);
}
