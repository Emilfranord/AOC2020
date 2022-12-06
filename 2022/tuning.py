import sys
def main():
    inp = input().strip()
    return (start_of_packet(inp), start_of_message(inp))

def start_of_packet(inp):
    for index in range(3, len(inp)):
        chars = [inp[index-k] for k in reversed(range(0,4))]
        if len(set(chars)) == 4:
            return index+1  

def start_of_message(inp):
    for index in range(13, len(inp)):
        chars = [inp[index-k] for k in reversed(range(0,14))]
        if len(set(chars)) == 14:
            return index+1

def state_of_general(inp, interval=4):
    for index in range(interval-1, len(inp)):
        chars = [inp[index-k] for k in reversed(range(0,interval))]
        if len(set(chars)) == interval:
            return index+1


if __name__ == "__main__":
    print(main())
