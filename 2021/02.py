def missionI():
	lst = []
	forword = 0;
	depth = 0;
	while True:
		try:
			instruction =  input()
			inst = int(instruction.split(" ")[1])
			if "forward" in instruction:
				forword = forword + inst
				
			if "down" in instruction:
				depth = depth + inst
				
			if "up"  in instruction:
				depth = depth - inst
		except EOFError:
			break
	print(forword * depth);
	
	
def missionII():
	lst = []
	forword = 0;
	depth = 0;
	aim = 0; 
	while True:
		try:
			instruction =  input()
			inst = int(instruction.split(" ")[1])
			if "forward" in instruction:
				forword = forword + inst
				depth = depth + aim*inst
				
			if "down" in instruction:
				aim = aim + inst # down X increases your aim by X units.
				
			if "up"  in instruction:
				aim = aim - inst # up X decreases your aim by X units.
		except EOFError:
			break
		
	
	print(forword * depth);



if __name__ == "__main__":
	#missionI()
	missionII()
	
	
	
	
	
	
	
	
	