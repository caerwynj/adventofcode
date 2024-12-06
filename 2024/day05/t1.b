implement Command;
include "cmd.m";

total := 0;
Item: adt {
	name:	string;
	mark:	int;
	succ:	cyclic list of ref Item;	# node's successors

	precede:	fn(a: self ref Item, b: ref Item);
};
Q: adt {
	item:	ref Item;
	next:	cyclic ref Q;
};

items, itemt: ref Q;	# use a Q not a list only to keep input order
nitem := 0;
dep: list of ref Item;

main(argv:list of string)
{
	print("AoC 5.1\n");
	argv = tl argv;

	input(hd argv);
	lines := getlines(hd tl argv);
	print("lines: %d\n", len lines);

	total, mids, i: int = 0;

	b1: for (l := lines; l != nil; l = tl l) {
		(n, ls) := tokenize(hd l, ",\n");
		tsort(ls);
		b := array[n] of int;
		i = 0;
		last := -1;
		for (; ls != nil; ls = tl ls) {
			m := int hd ls;
			k := find(string m, dep);
			#print("%d..%d, ", m, k);
			b[i++] = int m;
			if (k < last)
				continue b1;
			last = k;
		}
		total++;
		mids += b[n/2];
	}
	print("Total %d, mids %d\n", total, mids);

}







reset()
{
	dep = nil;
	for(k := items; k != nil; k = k.next)
		k.item.mark = 0;
}

output()
{
	for(k := items; k != nil; k = k.next)
		if((q := k.item).mark == 0)
			visit(q, nil);
	for(; dep != nil; dep = tl dep)
		print("%s", (hd dep).name+"\n");
}

find(k: string, a: list of ref Item): int
{
	i := 0;
	for(; a != nil; a = tl a) {
		if((hd a).name == k)
			return i;
		i++;
	}
	return -1;
}

input(f: string)
{
	b := bufio->open(f, Sys->OREAD);
	while((line := b.gets('\n')) != nil){
		(nil, fld) := sys->tokenize(line, "| \t\n");
		if(fld != nil){
			a := finditem(hd fld);
			while((fld = tl fld) != nil)
				a.precede(finditem(hd fld));
		}
	}
}

finditem(s: string): ref Item
{
	# would use a hash table for large sets
	for(il := items; il != nil; il = il.next)
		if(il.item.name == s)
			return il.item;
	i := ref Item;
	i.name = s;
	i.mark = 0;
	if(items != nil)
		itemt = itemt.next = ref Q(i, nil);
	else
		itemt = items = ref Q(i, nil);
	nitem++;
	return i;
}

Item.precede(a: self ref Item, b: ref Item)
{
	if(a != b){
		for(l := a.succ; l != nil; l = tl l)
			if((hd l) == b)
				return;
		a.succ = b :: a.succ;
	}
}


tsort(l: list of string): list of ref Item
{
	reset();
	#for(ll := l; ll != nil; ll = tl ll) print("%s ", hd ll);
	#print("\n");

	for(al := l; al != nil; al = tl al)
	for(k := items; k != nil; k = k.next)
		if((q := k.item).mark == 0 && hd al == k.item.name)
			visit(q, l);
	return dep;
}

visit(q: ref Item, l: list of string)
{
	#print("visit %s\n", q.name);
	q.mark = 2;
	for(sl := q.succ; sl != nil; sl = tl sl) {
		if((s := hd sl).mark == 0) {
			if(l == nil) visit(s, l);
			else for(al := l; al != nil; al = tl al)
				if(s.name == hd al)
					visit(s, l);
		} else if(s.mark == 2){
			print("cycle %s\n", s.name);
			sys->fprint(sys->fildes(2), "tsort: cycle in input\n");
			raise "cycle";
		}
	}
	q.mark = 1;
	dep = q :: dep;
}
