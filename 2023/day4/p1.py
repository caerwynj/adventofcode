f = open("input", "r")
lines = f.readlines()

def main():
    total = 0
    for line in lines:
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
                 if x == 0:
                     x = 1
                 else:
                     x *= 2
         total += x
         print(f"total for card {g} {x}")
    print(f"total {total}")
        

main()

