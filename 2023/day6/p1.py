import re

f = open("input", "r")
lines = f.readlines()

times = [int(i) for i in re.findall(r"[0-9]+", lines[0])]
dist  = [int(i) for i in re.findall(r"[0-9]+", lines[1])]
counts = [0 for i in range(0, len(times))]

print(times)
print(dist)

cnt = 0
for i,j in enumerate(times):
    for k in range(0,j):
        t = (j - k) * k
        if t > dist[i]:
            counts[i] += 1
        #print(f"{i} {j} {t} {t > dist[0]}")

print(f"count {counts[0]}")
total = 1
for i in counts:
    total *= i

print(total)
