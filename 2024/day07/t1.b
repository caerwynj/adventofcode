implement Command;
include "cmd.m";


main(argv:list of string)
{
	print("AoC 7.1\n");
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
		ops := 0;
		b1: while(ops < 1<<(n-1)){
			total := d[0];
			for(i=0; i< n-1; i++) {
				if(ops&(1<<i))
					total *= d[i+1];
				else
					total += d[i+1];
			}

			if(total == answer){
				solutions++;
				sum += answer;
				break b1;
			}
			ops++;
		}
	}
	print("solutions %d sum %bd\n", solutions, sum);
}

# Given n numbers generate the 2^(n-1) permutations of 2 binary operators
# For n=4 the perms are +++, ++*, +*+, +**, *++, *+*, **+, ***.
# However, we don't need to proceed when the result is already > answer.
# We start with no '*' and move up to n-1. 
# We don't go further if all the permutations > answer. 

d := array[32] of { * => big 0};
n := 0;
solutions := 0;
answer := big 0;

