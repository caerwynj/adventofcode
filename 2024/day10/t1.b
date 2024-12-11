implement Command;
include "cmd.m";

stk : list of (int, int, int, int, int);
q: array of list of (int,int);

main(argv:list of string)
{
	print("AoC 10.1\n");
	argv = tl argv;

	lines := getlines(hd argv);
	m, n, i, j, k, w, r : int = 0;
	m = len lines;
	n = len hd lines - 1;
	L := m + 2 ;
	v := array[(m+2) * (n+2)] of {* => -1};
	q = array[(m+2) * (n+2)] of list of (int, int);

	print("m %d n %d\n", m, n);
	#printmat(v, m+2,n+2,L);
	for (i = 1; i <= m; i++) {
		row := hd lines;
		for (j = 1; j <= n; j++)
			v[i+L*j] = row[j-1] - '0';
		lines = tl lines;
	}

	#printmat(v, m+2,n+2,L);
	for (i = 1; i <= m; i++) {
		for (j = 1; j <= n; j++) {
			if (v[i+L*j] == 0) {
				chk(v, i, j, i, j, L, 1);
			}
		}
	}

	while (stk != nil) {
#	print("len stk %d\n", len stk);
		(i, j, w, r, k) = hd stk;
		stk = tl stk;
		if(k == 9) {
			add(i,j,L,w,r);
			#print("%d %d %d %d\n", i, j, w, r);
		} else if (k < 9) 
			chk(v, i, j, w, r, L, k+1);
	}
	#printmat(v, m+2,n+2,L);
	total := 0;
	for(i=1;i<=m;i++)
		for(j=1;j<=n;j++)
			total += len q[i+L*j];
	print("Total %d\n", total);
}

add(i,j,L,w,r: int)
{
	for(l := q[i+L*j]; l != nil; l = tl l)
		if((hd l).t0 == w && (hd l).t1 == r)
			return;
	q[i+L*j] = (w,r) :: q[i+L*j];
	return;
}
chk(v: array of int, oi, oj, i, j, L, k: int)
{
	if (v[(i-1)+L*j] == k)
		stk = (oi, oj, i-1, j, k) :: stk;
	if (v[(i+1)+L*j] == k)
		stk = (oi, oj, i+1, j, k) :: stk;
	if (v[i+L*(j-1)] == k)
		stk = (oi, oj, i, j-1, k) :: stk;
	if (v[i+L*(j+1)] == k)
		stk = (oi, oj, i, j+1, k) :: stk;
	
}

printmat(a: array of int, m,n,L: int) 
{
	for (i:=0; i < m; i++){
		for(j:=0; j < n; j++){
			c := a[i+L*j];
			if (c == -1)
				print(".");
			else
				print("%d", c);
		}
		print("\n");
	}
}
