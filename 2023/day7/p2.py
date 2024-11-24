f = open("input", "r")
lines = f.readlines()

out = open("output", "w")

hands = [i.split(" ")[0].replace("A", "Z").replace("K", "Y").replace("T", "B").replace("J", "1") for i in lines]
bids = [i.split(" ")[1] for i in lines]

labels = list("ZYQB987654321")
# count number of each labels.
# assign to type based on distribution
# sort within each type

def gettyp(hand):
    c = dict()
    for i in list(hand):
        if i in c:
            c[i] += 1
        else:
            c[i] = 1
    wild = c['1'] if '1' in c else 0
    s = sorted(c.items(), key=lambda x: x[1], reverse=True)
    #print(s)
    typ=0
    if s[0][1] == 5:
        typ=6
    elif s[0][1] == 4:
        if wild == 1 or wild == 4:
            typ = 6
        else:
            typ = 5
    elif s[0][1] == 3 and s[1][1] == 2:
        if wild == 3 or wild == 2:
            typ = 6
        else:
            typ = 4
    elif s[0][1] == 3:
        if wild == 3 or wild == 1:
            typ = 5
        else:
            typ=3
    elif s[0][1] == 2 and s[1][1] == 2:
        if wild == 2:
            typ = 5
        elif wild == 1:
            typ = 4
        else:
            typ = 2
    elif s[0][1] == 2:
        if wild == 2:
            typ = 3
        elif wild == 1:
            typ = 3
        else:
            typ=1
    else:
        if wild == 1:
            typ = 1
        else:
            typ=0
    return typ

all = []

for i, j in enumerate(hands[:]):
    t = gettyp(j)
    #print(t)
    all.append((j, t, int(bids[i])))
sall = sorted(all, key=lambda x: x[0], reverse=True)
sall = sorted(sall, key=lambda x: x[1], reverse=True)
sall.reverse()
for i in sall:
    print(i, file=out)
total = 0
for i, j in enumerate(sall):
   total += (i + 1) * j[2]
print(total)
