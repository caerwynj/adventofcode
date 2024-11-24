import re
import itertools 

lines = [list(i.strip()) for i in open("test", "r").readlines()]


def expand(lines):
    a = []
    for i, line in enumerate(lines):
        if re.match("^\.+$", "".join(line)):
            a.append(i)
    return a

def tranpose(a):
    x = [[] for i in range(len(a[0])) ]
    for i in range(len(a)):
        for j in range(len(a[0])):
            x[j].append(a[i][j])
    return x

rows = expand(lines)
a = transpose(lines)
cols = expand(a)
print(rows, cols)

coords = []
for i, ix in enumerate(a):
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

