implement Command;
include "cmd.m";
main(argv:list of string)
{
	print("AoC 13.1\n");
	argv = tl argv;

	lines := getlines(hd argv);
	a,b,c,d, b1, b2, det: int;
	x1, x2: real;
	l,r: string;
	total := 0;
	while(lines != nil){
		buta := hd lines;
		lines = tl lines;
		butb := hd lines;
		lines = tl lines;
		priz := hd lines;
		lines = tl lines;
		if (lines != nil && hd lines == "\n")
			lines = tl lines;

		(l,r) = splitl(buta[12:], ",");
		a = int l;
		c = int r[4:];
		(l,r) = splitl(butb[12:], ",");
		b = int l;
		d = int r[4:];
		(l,r) = splitl(priz[9:], ",");
		b1 = int l;
		b2 = int r[4:];

		print("%d %d %d %d %d %d\n", a, b, c, d, b1, b2);
		det =(a*d - b*c);
		if(det == 0) {
			print("det is zero %d\n", det);
			continue;
		}

		x1 = (1.0/real det)*real d* real b1 + (1.0/real det)* real -b* real b2;
		x2 = (1.0/real det)*real -c* real b1 + (1.0/real det) * real a* real b2;
		print("%g %g | %d %d \n", x1, x2, int x1, int x2);
		if(int x1 * a + int x2 * b == b1 && int x1 * c + int x2 *d == b2)
			total += 3* int x1 + int x2;
		else 
			print("no\n");

	}

	print("Total %d\n", total);

}

