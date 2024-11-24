f = open("input", "r")
olines = f.readlines()
lines = olines[:]

def reset():
    for i, l in enumerate(olines):
        lines[i] = list(l)

# step through matrix
# if find a symbol add all numbers adjacent
# mustn't include same number twice.
# if add a number replace it from the input with '.' .
NUM="0123456789"

def rp(ln, pos):
    k = pos
    s = ""
    while lines[ln][k] in NUM and k > 0:
        k -= 1
    if lines[ln][k] not in NUM:
        k += 1
    while lines[ln][k] in NUM:
        s += lines[ln][k]
        lines[ln][k] = '.'
        k += 1
    #print(f"\tnum {int(s)} {ln+1}:{pos}")
    print(f"{int(s)}")
    #print(f"{lines[ln]}")
    return int(s)


def main():
    reset()
    total = 0
    for i, line in enumerate(lines):
        for j, c in enumerate(list(line)):
            if c not in "0123456789.\n":
                #print(f"symbol {c} on {i+1}:{j} ")
                if i > 0 and lines[i-1][j] in NUM:
                    total += rp(i-1, j)
                if i > 0 and j > 0 and lines[i-1][j-1] in NUM:
                    total += rp(i-1, j-1)
                if i > 0 and j < len(lines[i-1]) and lines[i-1][j+1] in NUM:
                    total += rp(i-1, j+1)
                if j > 0 and lines[i][j-1] in NUM:
                    total += rp(i,j-1)
                if j < len(lines[i]) and lines[i][j+1] in NUM:
                    total += rp(i, j+1)
                if i < len(lines) and lines[i+1][j] in NUM:
                    total += rp(i+1, j)
                if i < len(lines) and j > 0 and lines[i+1][j-1] in NUM:
                    total += rp(i+1, j-1)
                if i < len(lines) and j < len(lines[i+1]) and lines[i+1][j+1] in NUM:
                    total += rp(i+1, j+1)
            #reset()
    print(total)

def output():
    with open("output", "w") as f:
        for l in lines:
            s = "".join(l)
            f.write(f"{s}")

def tr():
    for l in lines:
        for c in l:
            if c in NUM:
                print(c, end="")
            elif c in " \n":
                print("")
            else:
                print(" ", end="")


main()
output()
#tr()


