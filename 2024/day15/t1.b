implement Command;
include "cmd.m";
main(argv:list of string)
{
	print("AoC 15.1\n");
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
	n = len hd maplines - 1;
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
		for (j = 0; j < n; j++) {
			v[i+lda*j] = row[j];
			#print("%d, %c\n", i, r[j]);
			if (row[j] == '@')
				pos = (i, j);
		}
		maplines = tl maplines;
	}
	print("m %d n %d dir %d pos (%d,%d)\n", m, n, len directions, pos.t0, pos.t1);
	patrol(v, m, n, pos.t0, pos.t1, array of byte directions);
	printmat(v, m, n);
	total := 0;
	for(i=0;i<m;i++)
		for(j=0;j<n;j++)
			if(v[i+lda*j] == 'O') {
				#print("%d %d\n", i, j);
				total += 100*i+j;
			}
	print("Total %d\n", total);
}

patrol(a: array of int, m,n, i, j: int, p: array of byte): array of int
{
	L := m;
	dir : int;
	buf := array[32] of int;  # array of '.', '@', '0' to sort ascending.
	buf2 := array[32] of int;
	bn := 0;

	b1: while(len p > 0) {
		dir = int p[0];
		p = p[1:];
		#print("direction %c pos(%d,%d)\n", dir, i, j);
		starti := i;
		startj := j;
		bn = 0;
		case dir {
		'^' =>
			while(i >= 0 && a[i+L*j] != '#'){
				buf[bn] = a[i+L*j];
				bn++;
				if (a[i+L*j] == '.') break;
				i--;
			}
			mergesortnumeric(buf, buf2, bn);
			i = starti;
			for(k := 0; k < bn; k++) {
				a[i+L*j] = buf[k];
				if(a[i+L*j] == '@') starti = i;
				i--;
			}
			i = starti;
		'>' =>
			while(j < n && a[i+L*j] != '#'){
				buf[bn] = a[i+L*j];
				bn++;
				if (a[i+L*j] == '.') break;
				j++;
			}
			mergesortnumeric(buf, buf2, bn);
			j = startj;
			for(k := 0; k < bn; k++) {
				a[i+L*j] = buf[k];
				if(a[i+L*j] == '@') startj = j;
				j++;
			}
			j = startj;
		'v' =>
			while(i < m && a[i+L*j] != '#'){
				buf[bn] = a[i+L*j];
				bn++;
				if (a[i+L*j] == '.') break;
				i++;
			}
			mergesortnumeric(buf, buf2, bn);
			i = starti;
			for(k := 0; k < bn; k++) {
				a[i+L*j] = buf[k];
				if(a[i+L*j] == '@') starti = i;
				i++;
			}
			i = starti;
		'<' =>
			while(j >= 0 && a[i+L*j] != '#'){
				buf[bn] = a[i+L*j];
				bn++;
				if (a[i+L*j] == '.') break;
				j--;
			}
			mergesortnumeric(buf, buf2, bn);
			j = startj;
			for(k := 0; k < bn; k++) {
				a[i+L*j] = buf[k];
				if(a[i+L*j] == '@') startj = j;
				j--;
			}
			j = startj;
		}
	}

	return a;
}
