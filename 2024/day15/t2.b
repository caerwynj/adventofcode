implement Command;
include "cmd.m";
main(argv:list of string)
{
	print("AoC 15.2\n");
	argv = tl argv;

	lines := getlines(hd argv);
	m, n, i, j, lda : int = 0;
	v : array of int;
	pos : (int, int);
	maplines: list of string;
	directions: string;

	while(lines != nil) {
		if(hd lines == "\n")
			break;
		maplines = hd lines :: maplines;
		lines = tl lines;
	}
	maplines = revstr(maplines);
	m = len maplines;
	n = (len hd maplines - 1) *2;
	lda = m;
	v =  array[m * n] of {* => '.'};

	while(lines != nil) {
		line := hd lines;
		line = line[:len line - 1];
		directions += line;
		lines = tl lines;
	}

	for (i = 0; i < m; i++) {
		row := hd maplines;
		rown := 0;
		for (j = 0; j < n; j++) {
			v[i+lda*j] = row[rown];
			j++;
			case row[rown] {
			'#' => v[i+lda*j] = '#';
			'O' => v[i+lda*j] = ']'; v[i+lda*(j-1)] = '[';
			'.' => v[i+lda*j] = '.';
			'@' => v[i+lda*j] = '.'; pos = (i,j-1);
			}
			rown++;
		}
		maplines = tl maplines;
	}
	print("m %d n %d dir %d pos (%d,%d)\n", m, n, len directions, pos.t0, pos.t1);
	printmat(v,m,n);
	patrol(v, m, n, pos.t0, pos.t1, array of byte directions);
	printmat(v, m, n);
	total := 0;
	for(i=0;i<m;i++)
		for(j=0;j<n;j++)
			if(v[i+lda*j] == '[') {
				#print("%d %d\n", i, j);
				total += 100*i+j;
			}
	print("Total %d\n", total);
}

patrol(a: array of int, m,n, i, j: int, p: array of byte): array of int
{
	L := m;
	c, dir : int;
	buf := array[32] of int;  # array of '.', '@', '0' to sort ascending.
	buf2 := array[32] of int;
	bn := 0;
	frontier : list of (int,int,int);
	region : list of (int,int,int);

	starti := i;
	startj := j;
	b1: while(len p > 0) {
		dir = int p[0];
		p = p[1:];
		i = starti;
		j = startj;
		#printmat(a, m, n);
		#print("direction %c pos(%d,%d)\n", dir, i, j);
		bn = 0;
		frontier = nil;
		region = nil;
		flag := 0;
		case dir {
		'^' =>
			frontier = (i,j,0) :: nil;
			while(frontier != nil) {
				(i,j,flag) = hd frontier;
				frontier = tl frontier;
				c = a[i+L*j];
				#print("front %c (%d,%d)\n", c,i,j);
				case c {
				'@' => frontier = (i-1,j,0) :: frontier;
				'[' => frontier = (i-1,j,0) :: frontier;
					if(!flag) 
						frontier = (i,j+1,1) :: frontier;
				']' => frontier = (i-1,j,0) :: frontier;
					if(!flag) 
						frontier = (i,j-1,1) :: frontier;
				'#' => #print("# %d %d\n", i,j ); 
					continue b1;
				'.' => continue;
				}
				region = (i,j,c) :: region;
			}
			for(l := region; l != nil; l = tl l) {
				(i,j,c) = hd l;
				a[i+L*j] = '.';
			}
			for(l = region; l != nil; l = tl l) {
				(i,j,c) = hd l;
				a[i-1+L*j] = c;
				if (c == '@') starti = i-1;
			}
		'>' =>
			frontier = (i,j,0) :: nil;
			while(frontier != nil) {
				(i,j,flag) = hd frontier;
				frontier = tl frontier;
				c = a[i+L*j];
				#print("front %c (%d,%d)\n", c,i,j);
				case c {
				'@' => frontier = (i,j+1,0) :: frontier;
				'[' => frontier = (i,j+1,0) :: frontier;
				']' => frontier = (i,j+1,0) :: frontier;
				'#' => #print("# %d %d\n", i,j ); 
					continue b1;
				'.' => continue;
				}
				region = (i,j,c) :: region;
			}
			for(l := region; l != nil; l = tl l) {
				(i,j,c) = hd l;
				a[i+L*j] = '.';
			}
			for(l = region; l != nil; l = tl l) {
				(i,j,c) = hd l;
				a[i+L*(j+1)] = c;
				if (c == '@') startj = j+1;
			}
		'v' =>
			frontier = (i,j,0) :: nil;
			while(frontier != nil) {
				(i,j,flag) = hd frontier;
				frontier = tl frontier;
				c = a[i+L*j];
				case c {
				'@' => frontier = (i+1,j,0) :: frontier;
				'[' => frontier = (i+1,j,0) :: frontier;
					if(!flag) 
						frontier = (i,j+1,1) :: frontier;
				']' => frontier = (i+1,j,0) :: frontier;
					if(!flag) 
						frontier = (i,j-1,1) :: frontier;
				'#' => continue b1;
				'.' => continue;
				}
				region = (i,j,c) :: region;
			}
			for(l := region; l != nil; l = tl l) {
				(i,j,c) = hd l;
				a[i+L*j] = '.';
			}
			for(l = region; l != nil; l = tl l) {
				(i,j,c) = hd l;
				a[i+1+L*j] = c;
				if (c == '@') starti = i+1;
			}
		'<' =>
			frontier = (i,j,0) :: nil;
			while(frontier != nil) {
				(i,j,flag) = hd frontier;
				frontier = tl frontier;
				c = a[i+L*j];
				#print("front %c (%d,%d)\n", c,i,j);
				case c {
				'@' => frontier = (i,j-1,0) :: frontier;
				'[' => frontier = (i,j-1,0) :: frontier;
				']' => frontier = (i,j-1,0) :: frontier;
				'#' => #print("# %d %d\n", i,j ); 
					continue b1;
				'.' => continue;
				}
				region = (i,j,c) :: region;
			}
			for(l := region; l != nil; l = tl l) {
				(i,j,c) = hd l;
				a[i+L*j] = '.';
			}
			for(l = region; l != nil; l = tl l) {
				(i,j,c) = hd l;
				a[i+L*(j-1)] = c;
				if (c == '@') startj = j-1;
			}
		}
	}

	return a;
}
