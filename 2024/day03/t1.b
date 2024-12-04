implement Command;
include "cmd.m";

total := 0;

main(argv:list of string)
{
	print("AoC 3.1\n");
	argv = tl argv;

	lines := getlines(hd argv);
	print("lines: %d\n", len lines);
	(re, e) := regex->compile("mul\\([0-9]+,[0-9]+\\)", 1);

	for (l := lines; l != nil; l = tl l) {
		s := hd l;
		a := regex->execute(re, s);
		while (a != nil){
			n, m: int = 0;
			for (i := 0; i < len a; i++){
				(n,m) = a[i];
				x := domul(s[n:m]);
				total += x;
				print("%d %d %s = %d\n", n, m, s[n:m], x);
			}
			s = s[m:];
			a = regex->execute(re, s);
		}
	}
	print("Total %d\n", total);

}

domul(s: string): int
{
	s = s[4:len s - 1];
	(a,b) := str->splitl(s, ",");
	return int a * int b[1:];
}
