def main():
	inp = [int(x) for x in input().strip().split(",")]
	inp.sort()
	
	fish = {}
	empty_fish = {}
	for x in range(0,9):
		fish[x] = 0
		empty_fish[x] = 0
	
	for fish_day in inp:
		fish[fish_day] += 1
	
	for day in range(0,256):
		future_fish = empty_fish.copy()
		for x in range(0,8):
			future_fish[x] = fish[x+1]
		future_fish[6] = fish[0] + future_fish[6]
		future_fish[8] = fish[0]
		
		fish = future_fish
	print(fish)
	print(sum(fish.values()))

if __name__ == "__main__":
	main()