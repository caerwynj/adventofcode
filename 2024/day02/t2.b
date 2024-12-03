implement Command;
include "cmd.m";

main(argv:list of string)
{
	print("AoC 2.2\n");
	argv = tl argv;

	lines := getlines(hd argv);
	safe := 0;
	i := 0;
	b1: for (l := lines; l != nil; l = tl l) {
		i++;
		(n, sl) := tokenize(hd l, " ");
		skip, redo : int = 0;
		last := int hd sl;
		back : list of string;
		ascending := last < int hd tl sl;
		a := array[256] of int;
		level := 0;
		a[level++] = last;
		b2: for (k := tl sl; k != nil; k = tl k) {
			x := int hd k;
			d := last - x;
			back = hd k :: back;
			#print("%d %d \n", x, d);
			if ((d == 0) || 
				(ascending && (d > 0)) ||
				(ascending && (d < -3)) ||
				(!ascending && (d < 0)) ||
				(!ascending && (d > 3)) 
				) {
				if (skip == 0) {
					skip++;
					continue b2;
				}else if (skip == 1 && level >= 2) {
					skip++;  #backtrack
					back = tl back;
					k = hd back :: k;
					back = tl back;
					k = "dummy" :: k;
					level--;
					last = a[level-1];
					ascending = a[0] < int hd tl k;
					#print("%s:%d last %d, asc %d, level %d, %s, %s\n", hd argv, i, last, ascending, level, hd tl k, hd tl tl k);
					continue b2;
					
				} else if (redo == 0) {
					skip++;
					k = tl sl;
					last = int hd k;
					ascending = last < int hd tl k;
					redo++;
					continue b2;
				}
			#	print("%s:%d d:%d skips:%d, redos:%d unsafe %s\n", hd argv, i, d, skip, redo, hd l);
				print("%s", hd l);
				continue b1;
			}		
			last = x;
			a[level++] = x;
		}
		safe++;
		#print("%s:%d safe, skip %d, redo %d\n", hd argv, i, skip, redo);
	}
	print("%d\n", safe);
}

