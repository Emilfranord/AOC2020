import sys
def main():
    inp = [line.strip() for line in sys.stdin]

    one = sum([points(appear_both(value)) for value in inp])

    out = []
    for index in range(0, len(inp)-1, 3):
        out.append(points(appear_three(inp[index], inp[index+1], inp[index+2])))
    two = sum(out)

    return (one, two)

def appear_both(rucksack: str) -> str:
    if rucksack == "":
        return None
    compA, compB = rucksack[:len(rucksack)//2], rucksack[len(rucksack)//2:], 
    overlap = set(compA).intersection(set(compB))
    return list(overlap)[0]

def appear_three(alice: str, bob: str, charlie: str) -> str:
    overlap = set(alice).intersection(set(bob), set(charlie))
    return list(overlap)[0]

def points(char: str) -> int:
    if char == None:
        return 0
    if char.islower():
        return ord(char) - ord("a") +1
    else:
        return ord(char) - ord("A") +27

if __name__ == "__main__":
    assert appear_both("vJrwpWtwJgWrhcsFMMfFFhFp") == "p"
    assert points("p") == 16
    print(main())
    