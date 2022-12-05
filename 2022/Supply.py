import sys
def main():
    inp = [line.strip("\n") for line in sys.stdin]

    blank_line = inp.index("")

    stacks = inp[:blank_line-1][::-1]
    numbers = inp[blank_line-1]
    moves = inp[blank_line+1:]
    
    indexes = []
    for index, value in enumerate(numbers):
        if value.isnumeric():
            indexes.append(index)

    state = list("*") * len(indexes)

    for stack in stacks:
        for stack_index, inp_index in enumerate(indexes):
            if stack[inp_index].isalpha:
                state[stack_index] += (stack[inp_index])

    state = list(map(lambda x: x.replace("*", "").strip(), state))    
    state.insert(0, "")
    state = list(map(lambda x: list(x), state))

    # highest index is the one that is highest in the stack, and closest to the sky

    for amount, origin, destination in moves:
        pile = state[origin][-amount:]
        for value in pile:
            state[destination].append(value)
            state[origin].pop(-1)

    return "".join(list(map(lambda x: x[-1] if len(x) >0 else "", state)))

def move_segment(instruction: str) -> "tuple[int]":
    instruction = instruction.split()
    amount = int(instruction[1])
    origin = int(instruction[3])
    destination = int(instruction[5])
    return (amount, origin, destination)




if __name__ == "__main__":
    print(main())
    