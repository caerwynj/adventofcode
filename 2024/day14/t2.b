implement Command;
include "cmd.m";

Coord: adt {
	x, y, vx, vy: int;
};

main(argv:list of string)
{
	print("AoC 14.2\n");
	argv = tl argv;

	lines := getlines(hd argv);
	m, n, i, j, k, x, y, vx, vy, L, N: int = 0;
	m = 103;
	n = 101;
	L = m;
	N = 100;
	co : list of ref Coord;

	while (lines != nil) {
		(l, r) := splitl(hd lines, " ");
		p := l[2:];
		v := r[3: len r - 1];

		(l,r) = splitl(p, ",");
		r = r[1:];
		x = int l;
		y = int r;

		(l,r) = splitl(v, ",");
		r = r[1:];	
		vx = int l;
		vy = int r;
		co = ref Coord(x, y, vx, vy) :: co;

		lines = tl lines;
	}

	q0,q1,q2,q3, cnt : int = 0;
	a: array of int;
	b:= array[1024] of byte;
	mx := 0;
	do {
		sim(co, m, n, 1);
		cnt++;
		a = plot(co, m, n);
		mx = maxx(a, m, n);
		print("Count %d Max %d\n", cnt, mx);
	}while (mx < 10);
	printmat(a, m, n);
}

maxx(a: array of int, m,n: int): int
{
	max, row : int = 0;
	last := '.';
	for(i:=0;i<m;i++) {
		last = '.';
		row = 1;
		for(j:=0;j<n;j++) {
			if(a[i+m*j] == 'X' && last == 'X') {
				row++;
			} 
			if(row > max) max = row;
			else row = 1;
			last = a[i+m*j];
		}
		if(row>max) max = row;
		if(row == 10) print("row %d\n", i);
	}
	return max;	
}

is_symmetrical(a: array of int, m,n: int): int
{
	for(i:=40;i<m-40;i++)
		for(j:=40;j<n/2;j++)
			if(a[i+m*j] != a[i+m*(n-j-1)]) {
				#print("%d %d\n", i, j);
				return 0;
			}
	return 1;
}

test(m,n:int)
{
	cl: list of ref Coord;
	cl = ref Coord(0,1,0,0) :: ref Coord(n-1,1, 0, 0) ::
		ref Coord(4,1,0,0) :: ref Coord(n-5,1, 0, 0) :: nil;
	a := plot(cl, m, n);
	printmat(a, m, n);
	print("test: is symmetrical %d\n", is_symmetrical(a, m, n));

}

sim(co: list of ref Coord, m, n, N: int)
{
	q0,q1,q2,q3 : int = 0;
	for(l := co; l != nil; l = tl l) {
		c := hd l;
		c.x += N*c.vx;
		c.y += N*c.vy;
		c.x %= n;
		c.y %= m;
		if (c.x < 0) c.x += n;
		if (c.y < 0) c.y += m;	
	}
	return;
}

plot(co: list of ref Coord, m, n: int): array of int
{
	a := array[m*n] of {* => '.'};
	for(l := co; l != nil; l = tl l) {
		c := hd l;
		a[c.y+m*c.x] = 'X';
	}
	#printmat(a, m, n);
	return a;
}
