implement Command;
include "cmd.m";

total := 0;

main(argv:list of string)
{
	print("AoC 4.1\n");
	argv = tl argv;

	lines := getlines(hd argv);
	print("lines: %d\n", len lines);

}
