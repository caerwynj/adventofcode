f = open("input", "r")

#seeds = [1, 5, 9, 11, 31]
#seed_to_soil = [[10, 1, 10], [20, 30, 4]]
#mps = [seed_to_soil, soil_to_fert]

def readrng():
    line = f.readline()
    #print(line)
    line = f.readline()
    a = []
    while line != "\n":
        d, s, r = line.strip().split(" ")
        a.append((int(d), int(s), int(r)))
        line = f.readline()
        #print(line)
    return a 

def domap(n, m):
    for i in m:
        d, s, r = i
        if n >= s and n < (s+r):
            return d + (n-s)
    return n

def main():
    line = f.readline().strip()
    pre, rest = line.split(":")
    s = rest.strip().split(" ")
    seeds = [int(i) for i in s]
    f.readline()
    mps = []
    minimum = 0
    for i in range(0, 7):
        mps.append(readrng())

    for i in range(0, len(seeds)//2):
        k = seeds[i*2]
        r = seeds[(i*2)+1]
        print(f"k {k} r {r}")
        for x in range(k, k+r-1):
            for j in mps:
                x = domap(x, j)
            #print(f"x {x}")
            if minimum == 0 or x < minimum:
                minimum = x
    print(f" min {minimum}")

main()
