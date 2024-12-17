implement Command;
include "cmd.m";

d: array of int;
p: array of int;
L: int;

main(argv:list of string)
{
	print("AoC 16.1\n");
	argv = tl argv;

	lines := getlines(hd argv);
	m, n, i, j, k: int;
	m = len lines;
	n = len hd lines - 1;
	L = m;
	a := array[m*n] of int;
	start,end : int;
	d = array[m*n] of {* => 1000000};
	p = array[m*n] of {* => -1};
	vs : list of int;

	for(i=0;i<m;i++) {
		row := hd lines;
		for(j=0;j<n;j++) {
			a[i+L*j] = row[j];
			r := i+L*j;
			c := row[j];
			#print("i %d j %d i+L*j=%d\n", i, j, i+L*j);
			if(c == 'S') {
				print("start %d %d %d L %d\n", i, j, i+L*j, L);
				start = r;
				vs = r :: vs;
			} else if(c == 'E') {
				end = r;
				vs = r :: vs;
				a[i+L*j] = '.';
				print("end %d %d\n", i, j);
			}else if(c == '.')
				vs = r :: vs;
			}
		lines = tl lines;
	}
	print("%dx%d\n", m, n);
	printmat(a, m, n);

	S : list of int;
	u: int;
	d[start] = 0;
	print("start %d (%d,%d)\n", start, start%L, start/L);
	while (vs != nil) {
		(u, vs) = extractmin(vs);
		S = u :: S;
		i=u%L;
		j=u/L;
		pn := p[u];
		dy := i - pn%L;
		dx := j - pn/L;
		w := 1;
		if(a[i+1+L*j] == '.'){
			if (dx != 0)
				relax(u, i+1+L*j,1001);
			else relax(u, i+1+L*j, 1);
		}
		if(a[i-1+L*j] == '.'){
			if(dx != 0)
				relax(u, i-1+L*j, 1001);
			else relax(u, i-1+L*j, 1);
		}
		if(a[i+L*(j+1)] == '.'){
			if(dy != 0)
				relax(u, i+L*(j+1), 1001);
			else relax(u, i+L*(j+1), 1);
		}
		if(a[i+L*(j-1)] == '.'){
			if(dy != 0)
				relax(u, i+L*(j-1), 1001);
			else relax(u, i+L*(j-1), 1);
		}
	}
	
	x := p[end];
	while (x > 0){
		print("%d (%d,%d):%d, ", x, x%L,x/L, d[x]);
		x = p[x];
	}
	print("\nTotal %d\n", d[end]);
}

extractmin(ls: list of int): (int, list of int)
{
	min := 1000000;
	key := 0;
	for(l:= ls;l!=nil;l=tl l)
		if(d[hd l] < min) {
			min = d[hd l];
			key = hd l;
		}
	#print("min %d %d %d ls %d\n", min, key%L, key/L, ls == nil);
	if(min == 10000)
		for(l = ls; l != nil; l = tl l)
			print("%d d[] = %d, ", hd l, d[hd l]);
	
	nl: list of int;
	for(l = ls; l != nil; l = tl l)
		if(hd l != key) nl = hd l :: nl;
	return (key, nl);
}

relax(u, v, w: int)
{
	#print("relax %d:%d %d:%d %d\n", u,d[u],v,d[v],w);
	if(d[v] > d[u] + w) {
		d[v] = d[u] + w;
		p[v] = u;
	}	
}
