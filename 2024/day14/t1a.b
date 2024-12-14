implement Command;
include "cmd.m";
main(argv:list of string)
{
	print("AoC 14.1\n");
	argv = tl argv;

	lines := getlines(hd argv);

	x, y, m, n, w, h, N: int;
	quad := array[4] of {* => 0};
	w = 101;
	h = 103;
	N = 100;
	print("width %d height %d\n", w, h);
	while(lines != nil) {
		(l, r) := splitl(hd lines, " ");
		p := l[2:];
		v := r[3: len r - 1];

		(l,r) = splitl(p, ",");
		r = r[1:];
		x = int l;
		y = int r;

		(l,r) = splitl(v, ",");
		r = r[1:];	
		m = int l;
		n = int r;

		print("%d,%d %d,%d\t", x, y, m,n);

		x += N*m;
		y += N*n;
		x %= w;
		y %= h;
		if (x < 0) x += w;
		if (y < 0) y += h;
		print("%d %d \n", x, y );

		if(x < w/2) {
			if(y < h/2)
				quad[0]++;
			else if(y>h/2) quad[2]++;
		} else if (x > w/2)  {
			if(y<h/2)
				quad[1]++;
			else if(y>h/2) quad[3]++;
		}
		lines = tl lines;
	}
	print("Quads %d %d %d %d\n", quad[0], quad[1], quad[2], quad[3]);
	print("Total %d\n", quad[0]*quad[1]*quad[2]*quad[3]);
}

