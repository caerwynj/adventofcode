import itertools
import re

lines = [i.strip() for i in open("input", "r").readlines()]


def tf(r, c):
    #r = "?###????????"
    #a = ["###.", "##.", "#.", ".", ".", ".", "."]
    #c = [3,2,1]
    a = [("#" * i) + "_" for i in c]
    csum = sum(c) + len(c)
    for i in range(len(r) - csum + 1):
        a.append("_")
    print(f"tokens: {a}")
    rx = "^" + r.replace(".", "_").replace("?", ".") + "_$" #"^.###.........$"
    print(csum, len(r), len(r) - csum)
    print(f"pat1: {rx}")
    b = sorted(list(set(["".join(i) for i in itertools.permutations(a, len(a)) ])))
    x = "_+".join(['#' * i for i in c])
    print(f"pat2: {x}")
    count = 0
    for s in b:
        if re.match(".*" + x, s) and re.match(rx, s):
            print(s)
            count += 1

    print(count)
    return count

totalcnt = 0
for i in lines:
    r, c = i.split(" ")
    c = [int(j) for j in c.split(",")]
    print(f"input: {r}, {c}")
    totalcnt += tf(r, c)

print(f"total count: {totalcnt}")
