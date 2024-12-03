implement Command;
include "cmd.m";

main(argv:list of string)
{
	print("AoC 2.1\n");
	argv = tl argv;

	lines := getlines(hd argv);
	safe := 0;
	i := 0;
	b1: for (l := lines; l != nil; l = tl l) {
		i++;
		(n, sl) := tokenize(hd l, " ");
		last := int hd sl;
		ascending := 1;
		if (int hd tl sl <= last)
			ascending = 0;
		for (k := tl sl; k != nil; k = tl k) {
			x := int hd k;
			d := last - x;
			#print("%d \n", d);
			if ((d == 0) || 
				(ascending && (d > 0)) ||
				(ascending && (d < -3)) ||
				(!ascending && (d < 0)) ||
				(!ascending && (d > 3)) 
				)
				continue b1;		
			last = x;
		}
		safe++;
		#print("line %d safe\n", i);
		
	}
	print("%d\n", safe);
}

