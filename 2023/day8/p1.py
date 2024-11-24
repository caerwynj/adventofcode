import re

f = open("input", "r")
lines = f.readlines()

lr = list(lines[0].strip())

d = {}
starts = []

for i in lines[2:]:
    a = re.findall("[A-Z]+", i)
    d[a[0]] = (a[1], a[2])
    if a[0].endswith('A'):
        starts.append(a[0])

#print(d)
#print(starts)


curr = 'AAA'
count = 0
while curr != 'ZZZ':
    last = curr
    direction = lr.pop(0)
    dn = 0 if direction == 'L' else 1
    lr.append(direction)
    curr = d[curr][dn]
    count += 1
    print(f"{last} {direction} {curr}")

print(count)
