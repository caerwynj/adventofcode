implement Command;
include "cmd.m";
main(argv:list of string)
{
	print("AoC 11.2\n");
	argv = tl argv;

	lines := getlines(hd argv);
	(n, ls) := tokenize(hd lines, " \n");
	print("Len %d\n", n);
	nl : list of string;
	for(i:=0; i < 75; i++) {
		nl = nil;
		for(l := ls; l != nil; l = tl l) {
			s := hd l;
			if(s == "0")
				nl = "1" :: nl;
			else if(len s % 2 == 0){
				k := len s / 2;
				a := s[0:k];
				b := s[k:];
				while(len b > 1 && b[0] == '0') b = b[1:];
				nl = a :: b :: nl;
			} else
				nl = string (big s * big 2024) :: nl;
		}
		ls = nl;
	}
	#for(l:=ls; l != nil; l = tl l) print("%s ", hd l);
	print("Total %d\n", len ls);

}
