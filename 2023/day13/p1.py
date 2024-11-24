lines = [i.strip() for i in open("input", "r").readlines() ]

m = []
a = []
for i in lines:
    if len(i) == 0:
        m.append(a)
        a = []
    else:
        a.append(i)
m.append(a)
#print(m)

def findup(i):
    for j in range(len(i) - 1):
        if i[j] == i[j+1]:
            return j
    return None
            
def issym(i, j):
    k = j + 1
    while j >=0 and k < (len(i) - 1):
        if i[j] != i[k]:
            return False
        j -= 1
        k += 1
    return True

def tranpose(a):
    x = [[] for i in range(len(a[0])) ]
    for i in range(len(a)):
        for j in range(len(a[0])):
            x[j].append(a[i][j])
    for i, j in enumerate(x):
        x[i] = "".join(j)
    return x

total = 0
       
def doit(i):
    t = 0
    d = findup(i)
    if d != None:
        s = issym(i, d)
        if s == False:
            it = tranpose(i)
            for x in it:
                print(x)
            dt = findup(it)
            if dt != None:
                s = issym(it, dt)
                if s == True:
                    print(f"cols {s}, {dt + 1}")
                    t += (dt + 1)
        else:
            print(f"rows {s}, {d + 1}")
            t += (100 * (d + 1))
    return t

for i in m:
    #    for x in i:
    #    print(x)
    total += doit(i)
print(f"total {total}")
