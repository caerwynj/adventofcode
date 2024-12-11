implement Command;
include "cmd.m";

c := array[128] of list of (int, int);

main(argv:list of string)
{
	print("AoC 8.1\n");
	argv = tl argv;

	lines := getlines(hd argv);
	m, n, i, j, k : int = 0;
	m = len lines;
	n = len hd lines - 1;
	L := m;
	v := array[m * n] of {* => 0};
	q := array[m * n] of {* => 0};

	print("m %d n %d\n", m, n);
	for (i = 0; i < m; i++) {
		row := hd lines;
		for (j = 0; j < n; j++)
			v[i+L*j] = row[j];
		lines = tl lines;
	}

	for (i = 0; i < m; i++) 
		for (j = 0; j < n; j++) {
			x := v[i+L*j];
			if(x != '.') 
				c[x] = (i,j) :: c[x];
		}
	for (k = 0; k < len c; k++)
		for (l := c[k]; l != nil; l = tl l) {
			a := hd l;
			for (p := tl l; p != nil; p = tl p) {
				b := hd p;
				d := (b.t0 - a.t0, b.t1 - a.t1);
				a1 := (a.t0 - d.t0, a.t1 - d.t1);
				a2 := (b.t0 + d.t0, b.t1 + d.t1);
				
				#print("a(%d,%d) b(%d,%d) d(%d,%d) a1(%d,%d) a2(%d,%d)\n", a.t0, a.t1, b.t0, b.t1, d.t0, d.t1, a1.t0, a1.t1, a2.t0, a2.t1);
				(i,j) = a1;
				if(i >= 0 && i < m && j >= 0 && j < n) q[i+L*j]=1;
				(i,j) = a2;
				if(i >= 0 && i < m && j >= 0 && j < n) q[i+L*j]=1;
			}
		}
	total := 0;
	for (i = 0; i < len q; i++)
		total += q[i];
	print("Total %d\n", total);
}	