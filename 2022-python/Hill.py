import sys
def main():
    inp = [line.strip() for line in sys.stdin]
    
    nodes: dict[tuple[int,int], Node] = {}

    for y, line in enumerate(inp):
        for x, char_ in enumerate(line):
            char = ord(char_) - ord("a")
            node = Node(char)
            if char_ == "E":
                node.end = True
                node.height = ord("z") - ord("a")
            if char_ == "S":
                node.start = True
                node.height = ord("a") - ord("a")
            nodes[(x,y)] = node

    
    def get(key: tuple[int,int]) -> "Node":
        candidate = nodes.get(key)
        if candidate == None:
            return Node(-100)
        return candidate

    for (x,y), node in nodes.items():
        node.append(get((x+1,y)))
        node.append(get((x-1,y)))
        node.append(get((x,y+1)))
        node.append(get((x,y-1)))

    nodes_ = [x for x in nodes.values()]

    candidates = []

    for y, rows in enumerate(inp):
        for x, cols in enumerate(rows):
            candidates.append(steps_to_target(x,y, nodes))
    part_one = list(filter(lambda x: x is not None, candidates))[0]

    for node in nodes.values():
        if node.height == 0:
            node.start = True

    candidates = []

    for y, rows in enumerate(inp):
        for x, cols in enumerate(rows):
            candidates.append(steps_to_target(x,y, nodes))
    part_two = min(list(filter(lambda x: x is not None and x != 0, candidates)))
    return part_one, part_two

def steps_to_target(x:int,y:int, graph:"dict[tuple[int,int], Node]") -> int | None:

    initial = graph[(x,y)]
    if initial.start == False:
        return None

    dist: dict[Node, float | int] = {}
    prev: dict[Node, Node | None] = {}
    queue: list[Node] = []

    for vertex in graph.values():
        dist[vertex] = float("inf")
        prev[vertex] = None
        queue.append(vertex)
    dist[initial] = 0

    while queue:
        ind = queue.index(min(queue, key = lambda x: dist[x]))
        u = queue.pop(ind)

        for v in u.adjacent:
            if v not in queue:
                continue
            alternative = dist[u] + distance(u,v)
            if alternative < dist[v]:
                dist[v] = alternative
                prev[v] = u
            if u.end:
                break
    
    path = []
    u = [x for x in prev if x.end == True][0]
    while u is not None:
        path.append(u)
        u = prev[u]

    return len(path)-1

def distance(start:"Node", end:"Node", ) -> int | float:
    diff = start.height - end.height
    if diff < -1:
        return float("inf")
    else: 
        return 1

class Node:
    def __init__(self, height:int):
        self.adjacent: list[Node] = []
        self.height = height
        self.start = False
        self.end = False

    def append(self, Node:"Node") -> None:
        self.adjacent.append(Node)
    
    def __repr__(self) -> str:
        return str(self.height) + str(self.start) + str(self.end)
    

if __name__ == "__main__":
    print(main())