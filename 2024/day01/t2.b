implement Command;
include "cmd.m";

main(argv:list of string)
{
	print("AoC 1.2\n");
	argv = tl argv;
	l1 := readf(hd argv);
	l2 := readf(hd tl argv);

	cnt := array [99999] of { * => 0};
	for (l := l2; l != nil; l = tl l)
		cnt[hd l]++;
	tot := 0;
	for( ; l1 != nil; l1 = tl l1) {
		n1 := hd l1;
		tot += (n1 * cnt[hd l1]);
		l2 = tl l2;

	}
	print("tot %d\n", tot);
}

readf(f: string): list of int
{
	l : list of int;

	fd := bufio->open(f, Bufio->OREAD);
	while ((line := fd.gets('\n')) != nil) {
		(n, nil) := toint(line, 10);
		l = n :: l;
	}

	return l;
}
