lines = open("input", "r").readlines()

a = [list(i) for i in lines]
pipes="FLJ|7-"

def findS():
    for i,l in enumerate(a):
        for j,s in enumerate(l):
            if a[i][j] == 'S':
                return (i, j)

def findC(i, j):
    if a[i-1][j] in "F|":
        return (i-1, j)
    elif a[i+1][j] in "|J":
        return (i+1, j)
    elif a[i][j-1] in "-F":
        return (i, j-1)
    elif a[i][j+1] in "-7":
        return (i, j+1)

def direction(a, b):
    if a[0] == b[0] and a[1] > b[1]:
        return "E"
    elif a[0] == b[0] and a[1] < b[1]:
        return "W"
    elif a[0] > b[0]:
        return "N"
    else:
        return "S"

def walk(i, j, d):
    c = a[i][j]
    if c == "|" and d == "S":
        return (i+1, j, "S")
    elif c == "|" and d == "N":
        return (i-1, j, "N")
    elif c == "-" and d == "W":
        return (i, j-1, "W")
    elif c == "-" and d == "E":
        return (i, j+1, "E")
    elif c == "J" and d == "S":
        return (i, j-1, "W")
    elif c == "J" and d == "E":
        return (i-1, j, "N")
    elif c == "7" and d == "N":
        return (i, j-1, "W")
    elif c == "7" and d == "E":
        return (i+1, j, "S")
    elif c == "F" and d == "N":
        return (i, j+1, "E")
    elif c == "F" and d == "W":
        return (i+1, j, "S")
    elif c == "L" and d == "S":
        return (i, j+1, "E")
    elif c == "L" and d == "W":
        return (i-1, j, "N")
    else:
        raise Exception(f"unknown {c},{d}")
for i in lines:
    print(i, end="")
start = findS()
count = 0
c = findC(*start)
count += 1
d = direction(start, c)
print(f"start {start} {c} {a[c[0]][c[1]]} direction {d}")

while c != start:
    x = walk(c[0], c[1], d)
    count += 1
    c = (x[0], x[1])
    d = x[2]
    print(f"after: {a[c[0]][c[1]]} {d}, {c}")
print(f"count {count}   {count / 2}")
