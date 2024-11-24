f = open("input", "r")

#seeds = [1, 5, 9, 11, 31]
#seed_to_soil = [[10, 1, 10], [20, 30, 4]]
#mps = [seed_to_soil, soil_to_fert]
final = []

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
    for i in range(0, 7):
        mps.append(readrng())

    for i in seeds:
        x = i
        print(f"{x} -> ", end="")
        for j in mps:
            x = domap(x, j)
            print(f"{x} -> ", end="")
        print("")
        final.append(int(x))
    print(f" final {final}")
    print(f" min {min(final)}")

main()
