implement Command;
include "cmd.m";
main(argv:list of string)
{
	print("AoC 12.1\n");
	argv = tl argv;

	lines := getlines(hd argv);
	area := array[256] of {* => 0};
	perim := array[256] of {* => 0};
	i,j,k,m,n: int;
	l, ls: list of string;
	m = len lines;
	n = len hd lines - 1;
	L := m + 2;
	a := array[(m+2)*(n+2)] of {* => '.'};
	
	for(i=1; i<=m; i++) {
		row := hd lines;
		for(j = 1; j <= n; j++) {
			a[i+L*j] = row[j-1];
			#print("%c:%c", row[j-1], a[i+L*j]);
		}
		lines = tl lines;	
	}
	print("%d %d\n", m, n);
	printmat(a, m+2,n+2);
	for(i=1;i<=m;i++) {
		for(j=1;j<=n;j++) {
			k = a[i+L*j];
			#print("k %c ", k);
			area[k]++;
			p := 0;
			p += (a[i+1+L*j] != k);
			p += (a[i-1+L*j] != k);
			p += (a[i+L*(j-1)] != k);
			p += (a[i+L*(j+1)] != k);
			perim[k] += p;
		}
	}

	total := 0;
	for(i=0; i < len area; i++) {
		if(area[i] > 0) {
			print("area %c %d perim %d\n", i, area[i], perim[i]);
			total += area[i] * perim[i];
		}
	}
	print("Total %d\n", total);

}

