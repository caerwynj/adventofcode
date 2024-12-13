implement Command;
include "cmd.m";
main(argv:list of string)
{
	print("AoC 13.1\n");
	argv = tl argv;

	lines := getlines(hd argv);
	a,b,c,d, b1, b2, det: big;
	x1, x2: real;
	l,r: string;
	total :=  big 0;
	i := 1;
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
		a = big l;
		c = big r[4:];
		(l,r) = splitl(butb[12:], ",");
		b = big l;
		d = big r[4:];
		(l,r) = splitl(priz[9:], ",");
		b1 = big l + 10000000000000;
		b2 = big r[4:] + 10000000000000;

		print("%bd %bd %bd %bd %bd %bd\n", a, b, c, d, b1, b2);
		det =(a*d - b*c);
		if(det == big 0) {
			print("dt is zero %bd\n", det);
			continue;
		}

		x1 = (1.0/real det)*real d* real b1 + (1.0/real det)* real -b* real b2;
		x2 = (1.0/real det)* real -c* real b1 + (1.0/real det) * real a* real b2;
		print("%g %g | %bd %bd \n", x1, x2, big x1, big x2);
		if(big x1 * a + big x2 * b == b1 && big x1 * c + big x2 *d == b2) {
			total += big 3 * big x1 + big x2;
			print("%d yes\n", i);
		} else 
			print("%d no\n", i);
		i++;
	}

	print("Total %bd\n", total);

}

