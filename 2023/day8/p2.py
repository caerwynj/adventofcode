import re

f = open("input", "r")
lines = f.readlines()

lr = list(lines[0].strip())

d = {}
starts = []

for i in lines[2:]:
    a = re.findall("[A-Z0-9]+", i)
    d[a[0]] = (a[1], a[2])
    if a[0].endswith('A'):
        starts.append(a[0])

#print(d)
print(f"starts {starts}")

def endswithz(a):
    return all([i.endswith('Z') for i in a])

curr = starts
count = 0
while not endswithz(curr):
    direction = lr.pop(0)
    dn = 0 if direction == 'L' else 1
    lr.append(direction)
    curr = [d[i][dn] for i in curr]
    #curr = d[curr][dn]
    count += 1
    #print(f"{last} {direction} {curr}")

print(count)
