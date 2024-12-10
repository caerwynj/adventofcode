implement Command;
include "cmd.m";

main(argv:list of string)
{
	print("AoC 9.1\n");
	argv = tl argv;

	lines := getlines(hd argv);
	line := hd lines;
	line = line[:len line - 1]; # drop newline
	
	i, j, m, n, f, g, blk: int = 0;
	total := big 0;

	j = len line - 1;
	print("len %d, %d\n", i, j);
	n = line[i] - '0';
	m = line[j] - '0';
	f = line[i+1] - '0';
	do{
		#print("%c %c %d\n", line[i], line[j], n );
		while(n>0) {
			#print("+%d", i/2);
			total += big (blk * (i/2));
			blk++;
			n--;
		}
		b3: while(f>0 && j>=i) {
			while(m == 0 && j >= i){
				j -= 2;
				if(j <= i) break b3;
				m = line[j] - '0';
			}
			
			#print("-%d", j/2);
			total += big (blk * (j/2));
			blk++;
			f--;
			m--;
		}
		i += 2;
		if (i < len line)
			n = line[i] - '0';
		if((i+1) < len line)
			f = line[i+1] - '0';
	}while(i < j);
	while (m > 0){
		#print("=%d", j/2);
		total += big (blk * (j/2));
		blk++;
		m--;
	}
	print("\nTotal %bd  blk %d i %d j %d '%c'\n", total, blk, i, j, line[j]);
}	
