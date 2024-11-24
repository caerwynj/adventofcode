
with open("input", "r") as f:
    lines = f.readlines()

    sum = 0
    for l in lines:
        l = l.strip().lower()
        print(l)
        a = []
        for i in l: 
            if c in "0123456789":
                print(f"{c}")
                a.append(c)
        s = "0"
        if len(a) > 0:
            s = f"{a[0]}{a[-1]}"
            print(s)
        else:
            print("empty")
        d = int(s)
        sum += d
    print(f"total: {sum}")

