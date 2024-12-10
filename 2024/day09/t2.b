implement Command;
include "cmd.m";

main(argv:list of string)
{
	print("AoC 9.2\n");
	argv = tl argv;

	lines := getlines(hd argv);
	line := hd lines;
	line = line[:len line - 1]; # drop newline
	
	i, j, m, n, f, g, blk: int = 0;
	total := big 0;
	
	a := array[len line] of {* => 0};
	b := array[len line] of {* => 0};
	c := array[len line] of list of (int, int);
	moves : list of (int, int, int);

	for(i=0;i<len a;i++) {
		a[i] = line[i] - '0';
		if(i%2 == 0){
			b[i] = i/2;
			c[i] = (i/2, a[i]) :: nil;
		}else
			b[i] = -1;
	}
	dump(a,b);
	i = len b - 1;
	m = b[i];
	while(m > 0) {
		for (j = 0; j < i; j++) {
			if (b[j] == -1 && a[j] >= a[i]) {
				moves = (j, m, a[i]) :: moves;
				c[j] = (m, a[i]) :: c[j];
				c[i] = nil;
				a[j] -= a[i];
				b[i] = -1;
				break;
			}
		}
		i -= 2;
		m = b[i];
	}

	dump(a,b);
	for(l := moves; l != nil; l = tl l)
		print("(%d,%d,%d)\n", (hd l).t0, (hd l).t1, (hd l).t2);

	blk = 0;
	for(i=0; i< len c; i++) {
		rl: list of (int, int);
		for (l := c[i]; l != nil; l = tl l) rl = hd l :: rl;
	
		cnt := 0;
		for (l = rl; l != nil; l = tl l){
			cnt += (hd l).t1;
			for(j=0; j< (hd l).t1; j++) {
				print("%d", (hd l).t0);
				total += big (blk * (hd l).t0);
				blk++;
			}
		}
		if (b[i] == -1) for(j = a[i]; j > 0; j--){
			print(".");
			blk++;
		}
	}
	print("Total %bd\n", total);
}	

dump(a,b: array of int)
{
	i: int;
	for(i=0;i<len a;i++) 
		print("%d", a[i]);
	print("\n");
	for(i=0;i<len b;i++) 
		if (b[i] >=0) print("%d", b[i]);
		else print(".");
	print("\n");
}
