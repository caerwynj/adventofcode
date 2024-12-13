implement Command;
include "cmd.m";

x := array[32] of string;
di := array[32] of list of string;
l := 1;
n := 25;
solutions := 0;
lcnt := array[32] of { * => 0};

main(argv:list of string)
{
	print("AoC 11.2\n");
	argv = tl argv;

	lines := getlines(hd argv);
	(n, ls) := tokenize(hd lines, " \n");
	print("Len %d\n", n);

	di[l] = "0" :: nil;
	btrk();
	print("Total %d\n", solutions);

}

updated(): int
{
	s := x[l-1];

	if(s == "0") {
		di[l] = "1" :: nil;
	}else if(len s % 2 == 0){
		k := len s / 2;
		a := s[0:k];
		b := s[k:];
		while(len b > 1 && b[0] == '0') b = b[1:];
		di[l] = a :: b :: nil;
	} else
		di[l] = string (big s * big 2024) :: nil;

	return 0;
}

downdated()
{
	
}

visit()
{
	solutions += len di[l];	
}

pass():int
{
	return 1;
}

btrk()
{
	backtrack := 0;
	b2: for(;;) {
		if (l > n) {
			visit();
			backtrack = 1;
		} else {
			x[l] = hd di[l];
			di[l] = tl di[l];
		}
		if(0)print("l=%d x=%s %d\n", l, x[l], backtrack);
		lcnt[l]++;

		b3: for(;;) {
			if (!backtrack) {
				b := pass();
				if(0)print("pass %d\n", b);
				if (b) {
					l++;
					updated();
					continue b2;
				}
			}
			b4: for(;;) {
				if (!backtrack) {
					if (di[l] != nil){
						x[l] = hd di[l];
						di[l] = tl di[l];
						continue b3;
					}
				}
				# backtrack
				if(0)print("backtrack\n");
				backtrack = 0;
				#di[l] = 1;
				l--;
				if (l > 0)
					continue b4;
				else
					return;
			}
		}
	}
}

