import sys
import math
def main():
    inp = [line.strip() for line in sys.stdin]

    dimensions = len(inp[0])

    grid = {}
    visible = {}
    scores = {}

    for x in range(dimensions):
        for y in range(dimensions):
            grid[(x,y)] = int(inp[y][x])
            visible[(x,y)] = False

    for x in range(dimensions):
        for y in range(dimensions):
            visible[(x,y)] = check_visible(grid,dimensions, x, y)
            scores[(x,y)] = scenic_score(grid,dimensions, x, y)

    part_one = len(list(filter(lambda x: x == True,visible.values())))
    part_two = max(scores.values())

    return (part_one, part_two)

def scenic_score(grid, dimensions, x, y):
    tree_height = grid[(x, y)]
    countes = [0,0,0,0]
    for x_prime in reversed(range(0,x)):
        candidate_height = grid[(x_prime, y)]
        countes[0] +=1
        if candidate_height >= tree_height:
            break

    for x_prime in range(x+1,dimensions):
        candidate_height = grid[(x_prime, y)]
        countes[1] +=1 
        if candidate_height >= tree_height:
            break
          
    for y_prime in reversed(range(0,y)):
        candidate_height = grid[(x, y_prime)]
        countes[2] +=1
        if candidate_height >= tree_height:
            break

    for y_prime in range(y+1,dimensions):
        candidate_height = grid[(x, y_prime)]
        countes[3] +=1
        if candidate_height >= tree_height:
            break

    return math.prod(countes)

def check_visible(grid, dimensions, x, y):
    tree_height = grid[(x, y)]

    non_visible_directions = 0

    for x_prime in range(0,x):
        candidate_height = grid[(x_prime, y)]
        if candidate_height >= tree_height:
            non_visible_directions += 1
            break
    
    for x_prime in range(x+1,dimensions):
        candidate_height = grid[(x_prime, y)]
        if candidate_height >= tree_height:
            non_visible_directions += 1
            break

    for y_prime in range(0,y):
        candidate_height = grid[(x, y_prime)]
        if candidate_height >= tree_height:
            non_visible_directions += 1
            break
    
    for y_prime in range(y+1,dimensions):
        candidate_height = grid[(x, y_prime)]
        if candidate_height >= tree_height:
            non_visible_directions += 1
            break

    return non_visible_directions != 4

if __name__ == "__main__":
    print(main())
