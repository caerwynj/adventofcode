implement Command;
include "cmd.m";

main(argv:list of string)
{
	print("AoC 3.2\n");
	argv = tl argv;

	lines := getlines(hd argv);
	print("lines: %d\n", len lines);

	total := 0;
	enabled := 1;
	re, dore, donre: Re;
	rea := array[2] of Re;
	cnt := array[2] of {* => 0};
	(re, nil) = regex->compile("mul\\([0-9]+,[0-9]+\\)", 0);
	(rea[0], nil) = regex->compile("do\\(\\)", 0);
	(rea[1], nil) = regex->compile("don't\\(\\)", 0);

	for (l := lines; l != nil; l = tl l) {
		s := hd l;
		a := regex->execute(re, s);
		while (a != nil){
			(n,m) := a[0];
			t := s[:n];
			b := regex->execute(rea[enabled], t);
			while (b != nil) {
				cnt[enabled]++;
				enabled = 1 - enabled;
				t = t[b[0].t1:];
				b = regex->execute(rea[enabled], t);
			}
			x := domul(s[n:m]);
			total += x*enabled;
			print("%d %d %s = %d en %d\n", n, m, s[n:m], x, enabled);
			s = s[m:];
			a = regex->execute(re, s);
		}
	}
	print("Total %d, do %d don't %d\n", total, cnt[0], cnt[1]);

}

domul(s: string): int
{
	s = s[4:len s - 1];
	(a,b) := str->splitl(s, ",");
	return int a * int b[1:];
}
