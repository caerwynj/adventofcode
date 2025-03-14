implement Command;
include "cmd.m";

REG:adt {A,B,C: int;};
R: REG;

main(argv:list of string)
{
	n, i: int;
	a: array of int;
	l, sl, lines: list of string;
	s: string;

	print("AoC 17.1\n");
	argv = tl argv;

	lines = getlines(hd argv);
	for(l = lines; l != nil; l = tl l){
		s = hd l;
		if(s[0] == 'R') {
			s = s[8:];
			#print("%s\n", s);
			(n, sl) = tokenize(s, " :");
			case hd sl {
			"A" => R.A = int hd tl sl;
			"B" => R.B = int hd tl sl;
			"C" => R.C = int hd tl sl;
			}
			print("%d %d %d\n", R.A, R.B, R.C);
		}else if(s[0] == 'P') {
			s = s[9:];
			print("%s\n", s);
			(n, sl) := tokenize(s, " :,\n");
			print("nops %d\n", n);
			a = array[n] of int;
			i = 0;
			for(;sl!=nil; sl = tl sl)
				a[i++] = int hd sl;
		}
	}
	n = len a;
	out : list of int;
	for(i=0;i<n;i+=2) {
		operand := 0;
		#print("op %d %d\n", a[i], a[i+1]);
		case a[i+1] {
		0 or 1 or 2 or 3 => operand = a[i+1];
		4 => operand = R.A;
		5 => operand = R.B;
		6 => operand = R.C;
		}
		case a[i] {
		0 => R.A = R.A / 2**operand;  	#adv
		1 => R.B = R.B ^ a[i+1];  	#bxl
		2 => R.B = operand % 8;  	#bst
		3 => if(R.A) i=a[i+1]-2;  	#jnz
		4 => R.B = R.B ^ R.C;  		#bxc
		5 => out = operand % 8 :: out;  #out
		6 => R.B = R.A / 2**operand;  	#bdv
		7 => R.C = R.A / 2**operand;  	#cdv
		}
	}
	out = revint(out);
	for(li := out; li != nil; li = tl li)
		print("%d,", hd li);
	print("\n");
}
