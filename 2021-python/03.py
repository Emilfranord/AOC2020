def missionI():
	gamma_rate = ""
	epsilon_rate = ""
	lst = []
	while True:
		try:
			n = input()
		except EOFError:
			break
		lst.append(n)
	
	for index in range(0,len(lst[0])-1):
		zero_count = 0
		one_count = 0
		for value in lst:
			if value[index] == "0":
				#print("here")
				zero_count += 1
			else:
				one_count += 1
		
		if zero_count > one_count:
			gamma_rate += "0"
			epsilon_rate += "1"
		else:
			gamma_rate += "1"
			epsilon_rate += "0"
	
	
	gamma_rate = int(gamma_rate, 2)
	epsilon_rate = int(epsilon_rate, 2)
	print(gamma_rate*epsilon_rate)
	

def missionII():	
	lst = []
	while True:
		try:
			n = input()
		except EOFError:
			break
		lst.append(n)
	
	oxygen = [x for x in lst]
	for index in range(0,len(lst[0])-1):
		zero_count = 0
		one_count = 0
		for value in oxygen:
			if value[index] == "0":
				zero_count += +1
			else:
				one_count += +1
		
		if one_count >= zero_count:
			oxygen = [x for x in oxygen if x[index] == "1"]
		else:
			oxygen = [x for x in oxygen if x[index] == "0" ]
		if len(oxygen) == 1:
			break;


	carbon = [x for x in lst]
	for index in range(0,len(lst[0])-1):
		zero_count = 0
		one_count = 0
		for value in carbon:
			if value[index] == "0":
				zero_count += 1
			else:
				one_count += 1
		
		if one_count < zero_count:
			carbon = [x for x in carbon if x[index] == "1"]
		else:
			carbon = [x for x in carbon if x[index] == "0"]
		
		if len(carbon) == 1:
			break;
	print(int(oxygen[0],2) * int(carbon[0],2))


if __name__ == "__main__":
	#missionI()
	missionII()
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	