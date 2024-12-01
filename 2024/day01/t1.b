implement Command;
include "cmd.m";

main(argv:list of string)
{
	print("AoC 1.1\n");
	argv = tl argv;
	l1 := readf(hd argv);
	l2 := readf(hd tl argv);

	tot := 0;
	m := len l1;
	for( ; l1 != nil; l1 = tl l1) {
		n1 := hd l1;
		n2 := hd l2;
		if (n1 > n2)
			tot += (n1 - n2);
		else
			tot += (n2 - n1);
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
