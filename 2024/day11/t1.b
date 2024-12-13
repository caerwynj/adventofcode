implement Command;
include "cmd.m";
main(argv:list of string)
{
	print("AoC 11.1\n");
	argv = tl argv;

	lines := getlines(hd argv);
	(n, ls) := tokenize(hd lines, " \n");
	print("Len %d\n", n);
	nl : list of string;
	for(i:=0; i < 25; i++) {
		nl = nil;
		for(l := ls; l != nil; l = tl l) {
			s := hd l;
			if(s == "0") {
				nl = "1" :: nl;
				#print("%d seen 0\n", i);	
			}else if(len s % 2 == 0){
				k := len s / 2;
				a := s[0:k];
				b := s[k:];
				while(len b > 1 && b[0] == '0') b = b[1:];
				nl = a :: b :: nl;
			} else
				nl = string (big s * big 2024) :: nl;
		}
		ls = nl;
	#for(l=ls; l != nil; l = tl l) print("%s ", hd l);
	print("len %d\n", len ls);
	}
	print("Total %d\n", len ls);

}
