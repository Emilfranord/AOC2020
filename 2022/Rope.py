import sys
def main():
    inp = [line.strip() for line in sys.stdin]

    tail_positions = set()

    head = (0,0)
    tail = (0,0)
    tail_positions.add(tail)

    change = lambda t, dx,dy: (t[0]+dx, t[1]+dy)

    for instruction in inp:
        direction, length = instruction.split()
        for _ in range(int(length)):
            match direction:
                case "L":
                    head = change(head, -1, 0)
                case "R":
                    head = change(head, 1, 0)
                case "U":
                    head = change(head, 0, 1)
                case "D":
                    head = change(head, 0, -1)

            if not touching(head, tail):
                match direction:
                    case "L":
                        x = 1 if tail[1] < head[1] else -1
                        x = 0 if in_line(head, tail) else x
                        tail = change(tail, -1, x)
                    case "R":
                        x = 1 if tail[1] < head[1] else -1
                        x = 0 if in_line(head, tail) else x
                        tail = change(tail, 1, x)
                    case "U":
                        x = 1 if tail[0] < head[0] else -1
                        x = 0 if in_line(head, tail) else x
                        tail = change(tail, x, 1)
                    case "D":
                        x = 1 if tail[0] < head[0] else -1
                        x = 0 if in_line(head, tail) else x
                        tail = change(tail, x, -1)

            tail_positions.add(tail)
    part_one = len(tail_positions)
    part_two = "Not implemnted"
    return (part_one, part_two)

def touching(head, tail):
    area = []
    for x in range(-1, 2):
        for y in range(-1, 2):
            area.append((head[0]+x, head[1]+y))
    return tail in area

def in_line(head, tail):
    return head[0] == tail[0] or head[1] == tail[1]

if __name__ == "__main__":
    print(main())