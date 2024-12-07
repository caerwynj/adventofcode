implement Command;
include "cmd.m";


ndarray: adt {
	m, L, n: int;
	a: array of int;
};

main(argv:list of string)
{
	print("AoC 6.1\n");
	argv = tl argv;

	lines := getlines(hd argv);
	m, n : int = 0;
	m = len lines;
	n = len hd lines - 1;
	lda := m;
	v := array[m * n] of {* => 0};
	pos : (int, int);

	print("m %d n %d\n", m, n);
	for (i := 0; i < m; i++) {
		row := hd lines;
		for (j := 0; j < n; j++) {
			v[i+lda*j] = row[j];
			#print("%d, %c\n", i, r[j]);
			if (row[j] == '^')
				pos = (i, j);
		}
		lines = tl lines;
	}
	nd := ndarray(m, lda, n, v);
	print("pos (%d,%d)\n", pos.t0, pos.t1);
	nd = patrol(nd, pos);
	printmat(nd);
	cnt := 0;
	for (i = 0; i < m*n; i++)
		if(nd.a[i] == 'X')
			cnt++;
	print("Total %d\n", cnt);
}

North, South, East, West: con iota;

patrol(nd: ndarray, start: (int, int)): ndarray
{
	a := nd.a;
	(m, n, L) := (nd.m, nd.n, nd.L);
	(i, j) := start;
	dir := North;

br := 0;
b1: while(br++ < 20000) {
#print("direction %d pos(%d,%d)\n", dir, i, j);
case dir {
North =>
	while(i >= 0 && a[i+L*j] != '#'){
		a[i+L*j] = 'X';
		i--;
	}
	if(i < 0) break b1;
	i++;
	dir = East;
East =>
	while(j < n && a[i+L*j] != '#'){
		a[i+L*j] = 'X';
		j++;
	}
	if(j >= n) break b1;
	j--;
	dir = South;
South =>
	while(i < m && a[i+L*j] != '#'){
		a[i+L*j] = 'X';
		i++;
	}
	if(i >= m) break b1;
	i--;
	dir = West;
West =>
	while(j >= 0 && a[i+L*j] != '#'){
		a[i+L*j] = 'X';
		j--;
	}
	if(j < 0) break b1;
	j++;
	dir = North;
}
}

	return ndarray(m, L, n, a);
}

printmat(nd: ndarray) 
{
	for (i:=0; i < nd.m; i++){
		for(j:=0; j < nd.n; j++){
			print("%c", nd.a[i+nd.L*j]);
		}
		print("\n");
	}
}	