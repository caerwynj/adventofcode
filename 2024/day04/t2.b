implement Command;
include "cmd.m";

main(argv:list of string)
{
	print("AoC 4.2\n");
	argv = tl argv;

	lines := getlines(hd argv);
	print("lines: %dx%d\n", len lines, len hd lines - 1);
	m := len lines;
	n := len hd lines - 1;

	a := array[m+8] of { * => array[n+8] of {* => '.'}};

	l := lines;
	for (i := 0; i < m; i++) {
		ln := hd l;
		#print("%s\n", ln);
		for (j := 0; j < n; j++) {
			a[i+4][j+4] = ln[j];
		}
		l = tl l;
	}
#	pr(a, m, n);

	sol := 0;
	for(i = 4; i < m+4; i++) {
		for(j := 4; j < n+4; j++) {
			if(a[i][j] == 'A') {
 sol += (a[i-1][j-1] == 'M'  && a[i+1][j+1] == 'S'
	&& a[i+1][j-1] == 'M' && a[i-1][j+1] == 'S');

 sol += (a[i-1][j-1] == 'S'  && a[i+1][j+1] == 'M'
	&& a[i+1][j-1] == 'M' && a[i-1][j+1] == 'S');


 sol += (a[i-1][j-1] == 'M'  && a[i+1][j+1] == 'S'
	&& a[i+1][j-1] == 'S' && a[i-1][j+1] == 'M');


 sol += (a[i-1][j-1] == 'S'  && a[i+1][j+1] == 'M'
	&& a[i+1][j-1] == 'S' && a[i-1][j+1] == 'M');

			}
		}
	}	
	print("Total %d\n", sol);
}
