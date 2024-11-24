import re

f = open("input", "r")
lines = f.readlines()

times = "".join(re.findall(r"[0-9]+", lines[0]))
dist  = "".join(re.findall(r"[0-9]+", lines[1]))

print(times)
print(dist)

cnt = 0
tim = int(times)
dis = int(dist)

print(tim, dis)

def dot(n, end):
    return ((end - n) * n) > dis


print(f"count {cnt}")

