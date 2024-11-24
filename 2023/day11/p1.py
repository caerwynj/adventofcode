import re
import itertools 

lines = [list(i.strip()) for i in open("input", "r").readlines()]

def expand(lines):
    a = []
    for i in lines:
        if re.match("^\.+$", "".join(i)):
            a.append(i)
        a.append(i)
    return a

def tranpose(a):
    x = [[] for i in range(len(a[0])) ]
    for i in range(len(a)):
        for j in range(len(a[0])):
            x[j].append(a[i][j])
    return x

a = expand(lines)
at = tranpose(a)
ax = expand(at)
ax = tranpose(ax)

for i in ax:
    print(i)

coords = []
for i, ix in enumerate(ax):
    for j, jx in enumerate(ix):
        if jx == '#':
            coords.append((i, j))

def length(a, b):
    x, y = 0, 0
    x = abs(a[0] - b[0])
    y = abs(a[1] - b[1])
    return x, y
        
#print(coords)
total = 0
for i in itertools.combinations(coords, 2):
    #print(i)
    a, b = i
    x,y = length(a, b)
    total += x + y 
    #print(f"{i} {(x, y)} {x+y}") 
print(f"total {total}")

#9591768

