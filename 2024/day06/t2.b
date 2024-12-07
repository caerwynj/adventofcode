implement Command;
include "cmd.m";


ndarray: adt {
	m, L, n: int;
	a: array of int;
};

main(argv:list of string)
{
	print("AoC 6.2\n");
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
			c := 0;
			if (row[j] == '^')
				pos = (i, j);
			if(row[j] == '#') c = Wall;
			v[i+lda*j] = c;
			#print("%d, %c\n", i, r[j]);

		}
		lines = tl lines;
	}
	nd := ndarray(m, lda, n, v);
	nd1 := copy(nd);
	print("pos (%d,%d)\n", pos.t0, pos.t1);
	loop := 0;
	(nd, loop) = patrol(nd, pos);
	printmat(nd);
	cnt := 0;
	for (i = 0; i < m*n; i++)
		if(nd.a[i] & (North|South|East|West))
			cnt++;
	print("Total %d, loop %d \n", cnt, loop);

	loopcnt := 0;
	for (i = 0; i < m; i++) {
		for (j := 0; j < n; j++) {
			if (i == pos.t0 && j == pos.t1 || nd.a[i+lda*j] & Wall)
				continue;
			if(nd.a[i+lda*j] & (North|South|East|West)) {
				nd2 := copy(nd1);
				nd2.a[i+lda*j] = Wall;
				(nil, loop) = patrol(nd2, pos);
				loopcnt += loop;
			}

		}
	}
	print("loop count %d\n", loopcnt);
}

North, South, East, West, Wall: con 1<<iota;

patrol(nd: ndarray, start: (int, int)): (ndarray, int)
{
	a := nd.a;
	(m, n, L) := (nd.m, nd.n, nd.L);
	(i, j) := start;
	dir := North;
loop := 0;
br := 0;
b1: while(br++ < 20000) {
	if(a[i+L*j] & dir) {
		loop++;
		break;
	}
	case dir {
	North =>
		while(i >= 0 && !(a[i+L*j] & Wall)){
			a[i+L*j] |= North;
			i--;
		}
		if(i < 0) break b1;
		i++;
		dir = East;
	East =>
		while(j < n && !(a[i+L*j] & Wall)){
			a[i+L*j] |= East;
			j++;
		}
		if(j >= n) break b1;
		j--;
		dir = South;
	South =>
		while(i < m && !(a[i+L*j] & Wall)){
			a[i+L*j] |= South;
			i++;
		}
		if(i >= m) break b1;
		i--;
		dir = West;
	West =>
		while(j >= 0 && !(a[i+L*j] & Wall)){
			a[i+L*j] |= West;
			j--;
		}
		if(j < 0) break b1;
		j++;
		dir = North;
	}
}

	return (ndarray(m, L, n, a), loop);
}

printmat(nd: ndarray) 
{
	for (i:=0; i < nd.m; i++){
		for(j:=0; j < nd.n; j++){
			c := nd.a[i+nd.L*j];
			if (c == 0)
				print(".");
			else if(c & (North|South|East|West))
				print("X");
			else if(c & Wall)
				print("#");
		}
		print("\n");
	}
}

copy(nd: ndarray): ndarray
{
	ar := array[nd.m * nd.n] of int;
	ar[0:] = nd.a;
	return ndarray(nd.m, nd.L, nd.n, ar);
}

obstruct(nd: ndarray, start: (int, int)) 
{
	a := nd.a;
	(m, n, L) := (nd.m, nd.n, nd.L);
	(i, j) := start;
	dir := North;
# an obstruction must appear on the path already marked, except the first.
# The starting location is always the same.
# for each X on the grid add an obstruction then start the patrol.
# It either loops or exits the grid.
# It may crossover the path.
# We need to test if we visit a block going in the same direction.
# the patrol() needs to return if it found a loop or not.
}
