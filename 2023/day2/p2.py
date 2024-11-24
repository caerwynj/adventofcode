
RED = 12
GREEN = 13
BLUE = 14
TOTAL = RED + GREEN + BLUE
cols = {"red": 12, "green": 13, "blue": 14, "total": TOTAL}

f = open("input", "r")
lines = f.readlines()
gtotal = 0
for line in lines:
    max = {"red": 0, "green": 0, "blue": 0}
    line = line.strip()
    (game, rest) = line.split(":")
    print(game)
    _, gid = game.split(" ")
    #print(gid)
    rest = rest.strip()

    rounds = rest.split(";")
    possible = True
    for round in rounds:
        round = round.strip()
        tot = 0
        colors = round.split(",")
        for color in colors:
            color = color.strip()
            #print(color)
            (num, col) = color.split(" ")
            tot += int(num)
            if int(num) > max[col]:
                max[col] = int(num)
    power = max["red"] * max["green"] * max["blue"]
    gtotal += power

print(f"gid total {gtotal}")

