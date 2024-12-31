import sys
def main():
    inp = [line.strip() for line in sys.stdin]

    sums = []
    partial = 0
    for value in inp:
        if value == "":
            sums.append(partial)
            partial = 0
        else:
            partial+= int(value)
    return sum(sorted(sums, reverse = True)[:3])

if __name__ == "__main__":
    print(main())