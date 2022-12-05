def main():
	inp = [int(x) for x in input().strip().split(",")]
	inp.sort()

	# jpn3to post on -🎄- 2021 Day 7 Solutions -🎄-
	
	costs = []
	for value in range(min(inp), max(inp)+1): # since the list is sorted, we know that min is the first element, and that the last element is the biggest
		cost = 0
		for crab in inp:
			steps = abs(crab-value)
			cost += (steps*(steps+1))//2
		costs.append(cost)
		
	#print(costs)
	print(min(costs))

if __name__ == "__main__":
	main()