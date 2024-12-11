
include "sys.m";
sys: Sys;
print, sprint, tokenize: import sys;
include "draw.m";
include "math.m";
math: Math;
ceil, fabs, floor, Infinity, log10, pow10, pow, sqrt, exp: import math;
dot, gemm, iamax: import math;
include "string.m";
str: String;
append, drop, in, prefix, splitl, splitr, replace, contains,
splitstrl, splitstrr, take, tobig, toint, toreal, tolower, toupper: import str;
include "bufio.m";
bufio: Bufio;
Iobuf: import bufio;
include "regex.m";
regex: Regex;
Re: import regex;
include "hash.m";
hash: Hash;
HashTable, HashVal, HashNode: import hash;
include "sets.m";
sets: Sets;
Set, A, B: import sets;
include "lists.m";
lists: Lists;
# append
# combine, concat, delete, find, ismember, last, pair, reverse, unpair, allsat, anysat, filter, map, partition: import lists;

false, true: con iota;
bool: type int;

Command:module
{ 
	init:fn(ctxt: ref Draw->Context, argv: list of string); 
};

init(nil: ref Draw->Context, argv: list of string)
{
	sys = load Sys Sys->PATH;
	math = load Math Math->PATH;
	str = load String String->PATH;
	bufio = load Bufio Bufio->PATH;
	regex = load Regex Regex->PATH;
	hash = load Hash Hash->PATH;
	sets = load Sets Sets->PATH;
	sets->init();
	lists = load Lists Lists->PATH;
	main(argv);
}

getint(f: string): list of int
{
	l : list of int;

	fd := bufio->open(f, Bufio->OREAD);
	while ((line := fd.gets('\n')) != nil) {
		(n, nil) := toint(line, 10);
		l = n :: l;
	}

	return revint(l);
}

revstr(l: list of string): list of string
{
	k: list of string;
	for (; l != nil; l = tl l)
		k = hd l :: k;
	return k;
}

revint(l: list of int): list of int
{
	k: list of int;
	for (; l != nil; l = tl l)
		k = hd l :: k;
	return k;
}

getlines(f: string): list of string
{
	l : list of string;

	fd := bufio->open(f, Bufio->OREAD);
	while ((line := fd.gets('\n')) != nil)
		l = line :: l;
	return revstr(l);
}

sortint(l: list of int): array of int
{
	i: int;
	a := array[len l] of int;
	for (i = 0; l != nil; l = tl l)
		a[i++] = hd l;
	mergesortnumeric(a, array[len a] of int, len a);
	return a;
}

sortstr(l: list of string): array of string
{
	i: int;
	a := array[len l] of string;
	for (i = 0; l != nil; l = tl l)
		a[i++] = hd l;
	mergesort(a, array [len a] of string, len a);
	return a;
}

mergesort(a, b: array of string, r: int)
{
	if (r > 1) {
		m := (r-1)/2 + 1;
		mergesort(a[0:m], b[0:m], m);
		mergesort(a[m:r], b[m:r], r-m);
		b[0:] = a[0:r];
		for ((i, j, k) := (0, m, 0); i < m && j < r; k++) {
			if (b[i] > b[j])
				a[k] = b[j++];
			else
				a[k] = b[i++];
		}
		if (i < m)
			a[k:] = b[i:m];
		else if (j < r)
			a[k:] = b[j:r];
	}
}

mergesortnumeric(a, b: array of int, r: int)
{
	if (r > 1) {
		m := (r-1)/2 + 1;
		mergesortnumeric(a[0:m], b[0:m], m);
		mergesortnumeric(a[m:r], b[m:r], r-m);
		b[0:] = a[0:r];
		for ((i, j, k) := (0, m, 0); i < m && j < r; k++) {
			if (int b[i] > int b[j])
				a[k] = b[j++];
			else
				a[k] = b[i++];
		}
		if (i < m)
			a[k:] = b[i:m];
		else if (j < r)
			a[k:] = b[j:r];
	}
}
