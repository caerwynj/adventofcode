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
	size := (m+2)*(n+2);
	a := array[size] of {* => '.'};
	R = array[size] of int;
	LIST = array[size] of list of int;
	internal_name = array[size] of int;
	external_name = array[size] of int;
	
	for(i=1; i<=m; i++) {
		row := hd lines;
		for(j = 1; j <= n; j++) {
			a[i+L*j] = row[j-1];
			R[i+L*j] = i+L*j;
			LIST[i+L*j] = (i,j) :: nil;
			internal_name[i+L*j] = i+L*j;
			external_name[i+L*j] = i+L*j;
			#print("%c:%c", row[j-1], a[i+L*j]);
		}
		lines = tl lines;	
	}
	print("%d %d\n", m, n);
	printmat(a, m+2,n+2);
	for(i=1;i<=m;i++) {
		for(j=1;j<=n;j++) {
			k = a[i+L*j];

			if(a[i-1+L*j] == k) {
				w := find(i-1+L*j);
				q := find(i+L*j);
				union(w, q, w);
			}
			if(a[i+L*(j-1)] == k){
				w := find(i+L*(j-1));
				q := find(i+L*j);
				union(w, q, w);
			}
			#print("k %c ", k);
			area[k]++;
			#p := 0;
			#p += (a[i+1+L*j] != k);
			#p += (a[i-1+L*j] != k);
			#p += (a[i+L*(j-1)] != k);
		#	p += (a[i+L*(j+1)] != k);
		#	perim[k] += p;
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

R: array of int;
LIST: array of list of (int,int);
internal_name: array of int;
external_name: array of int;

union(i,j,k: int)
{
	a := internal_name[i];
	b := internal_name[j];
	l1 := LIST[a];
	l2 := LIST[b];
	if (len l2 < len l1){
		l1 = LIST[b];
		l2 = LIST[a];
	}
	for(l := l1; l != nil; l = tl l)
		R[hd l] = b;
	for(l = LIST[a]; l != nil; l = tl l)
		LIST[b] = hd l :: LIST[b];
	LIST[a] = nil;
	internal_name[k] = b;
	external_name[b] = k;
	
}

find(i: int): int
{
	return external_name[R[i]];
}

