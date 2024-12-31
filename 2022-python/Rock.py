import sys
def main():
    inp = [line.strip() for line in sys.stdin]
    
    total = sum(map(points, inp))
    
    return total

def points(pair):
    if pair == "":
        return 0
    alice, desired = pair.split()
    alice =     {"A":"r", "B":"p", "C":"s"}[alice]
    desired =   {"X":"l", "Y":"d", "Z":"w"}[desired]

    bob = {
        ("d","r"):"r",
        ("l","p"):"r",
        ("w","s"):"r",
        ("w","r"):"p",
        ("d","p"):"p",
        ("l","s"):"p",
        ("l","r"):"s",
        ("w","p"):"s",
        ("d","s"):"s"
    }[(desired, alice)]

    outcome = {
        ("r","r"):"d",
        ("r","p"):"l",
        ("r","s"):"w",
        ("p","r"):"w",
        ("p","p"):"d",
        ("p","s"):"l",
        ("s","r"):"l",
        ("s","p"):"w",
        ("s","s"):"d"
    }[(bob, alice)]

    points = {"l":0, "d":3, "w":6}[outcome] + {"r":1, "p":2, "s":3}[bob]

    return points

if __name__ == "__main__":
    print(main())