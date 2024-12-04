implement Command;
include "cmd.m";

main(argv:list of string)
{
	print("AoC 4.2\n");
	argv = tl argv;

	lines := getlines(hd argv);
	print("lines: %d\n", len lines);


}
