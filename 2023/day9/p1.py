import re

lines = open("input", "r").readlines()

total = 0
for ln in lines:
    #print(f"")
    d = []
    d1 = [int(i) for i in re.findall("[-0-9]+", ln)]
    #print(d1)
    while not all([i == 0 for i in d1]):
        d.append(d1[:])
        d1 = [d1[i] - d1[i-1] for i in range(1, len(d1))]
        #print(d1)
    d1.reverse()
    n = 0
    for i in range(0, len(d)):
        d[i].append(d[i][-1] + n)
        n = d[i][-1]
    #print(n)
    total += n
    
print(total)

