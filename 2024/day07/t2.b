implement Command;
include "cmd.m";


main(argv:list of string)
{
	print("AoC 7.2\n");
	argv = tl argv;

	lines := getlines(hd argv);
	sum := big 0;
	for(l := lines; l != nil; l = tl l) {
		(s, rest) := splitl(hd l, ":");
		answer = big s;
		ns: list of string;
		(n, ns) = tokenize(rest[1:], " \n");
		for(i:=0; i<n; i++) {
			d[i] = big hd ns;
			ns = tl ns;
		}
		for (i = 0; i<n; i++) ops[i] = 0;
		b1: do {
			total := d[0];
			for(i=0; i< n-1; i++) {
				if(ops[i+1] == 1)
					total *= d[i+1];
				else if (ops[i+1] == 2)
					total = big (string total + string d[i+1]);
				else
					total += d[i+1];
			}
			#print("answer %bd n %d total %bd \n", answer, n, total);
			if(total == answer){
				solutions++;
				sum += answer;
				break b1;
			}
		} while(update());
	}
	print("solutions %d sum %bd\n", solutions, sum);
}

# Given n numbers generate the 3^(n-1) permutations of 3 binary operators

ops := array[32] of int;
radix := 3;
d := array[32] of { * => big 0};
n := 0;
solutions := 0;
answer := big 0;

update(): int
{
	j := n;
	while (ops[j] == (radix-1)) {
		ops[j] = 0;
		j--;
	}
	if(j == 0)return 0;
	ops[j]++;
	return 1;
}
