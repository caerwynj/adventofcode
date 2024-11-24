f = open("input", "r")
lines = f.readlines()
cards = [1 for i in range(len(lines))]

def main():
    total = 0
    for i, line in enumerate(lines):
         x = 0
         g, rest = line.strip().split(":")
         print(g)
         wins, plays = rest.split("|")
         wn = wins.strip().split(" ")
         pn = plays.strip().split(" ")

         print(wn)
         for n in wn:
             if n.isalnum() and n in pn:
                 print(n)
                 x += 1
         total += x
         print(f"total for {g}: {x} wins, copies {cards[i]}")
         for k in range(i+1, i+x+1):
             print(f"card {cards[k]} {k} * {cards[i]}")
             if k < len(cards):
                cards[k] += cards[i]
    print(f"total {total}")
    totcards = 0
    for m in cards:
        totcards += m
    print(f"total cards {totcards}")

    
main()

