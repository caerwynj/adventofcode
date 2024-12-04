implement Command;
include "cmd.m";

total := 0;

main(argv:list of string)
{
	print("AoC 4.1\n");
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
	pr(a, m, n);

	sol := 0;
	for(i = 4; i < m+4; i++) {
		for(j := 4; j < n+4; j++) {
			if(a[i][j] == 'X') {
 sol += (a[i][j+1] == 'M' && a[i][j+2] == 'A' && a[i][j+3] == 'S');
 sol += (a[i][j-1] == 'M' && a[i][j-2] == 'A' && a[i][j-3] == 'S');
 sol += (a[i+1][j] == 'M' && a[i+2][j] == 'A' && a[i+3][j] == 'S');
 sol += (a[i-1][j] == 'M' && a[i-2][j] == 'A' && a[i-3][j] == 'S');
 sol += (a[i+1][j+1] == 'M' && a[i+2][j+2] == 'A' && a[i+3][j+3] == 'S');
 sol += (a[i-1][j-1] == 'M' && a[i-2][j-2] == 'A' && a[i-3][j-3] == 'S');
 sol += (a[i-1][j+1] == 'M' && a[i-2][j+2] == 'A' && a[i-3][j+3] == 'S');
 sol += (a[i+1][j-1] == 'M' && a[i+2][j-2] == 'A' && a[i+3][j-3] == 'S');
			}
		}
	}	
	print("Total %d\n", sol);
}

pr(a: array of array of int, m,n: int)
{

	for (i := 0; i < m+8; i++){
		for(j := 0; j < n+8; j++)
			print("%c", a[i][j]);
		print("\n");
	}
}

