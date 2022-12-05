import math
def main():
	lst = []
	while True:
		try:
			n = input().strip().split(" -> ")
			x1 = int(n[0].split(",")[0])
			y1 = int(n[0].split(",")[1])
			x2 = int(n[1].split(",")[0])
			y2 = int(n[1].split(",")[1])
			n = (x1,y1,x2,y2)
			
		except EOFError:
			break
		lst.append(n)
	
	#lst = [x for x in lst if x[0] == x[2] or x[1] == x[3]] # extract the non-slope lines
	
	height = {}
	for row in range(0, 1000):
			for col in range(0,1000):
				height[(row, col)] = 0
	
	for line in lst:
		for row in range(min(line[0], line[2]), max(line[0], line[2])+1):
			for col in range(min(line[1], line[3]), max(line[1], line[3])+1):
				if point_on_line(line, (row,col)):
					height[(row, col)] += 1

	#print(height)
	two_height = []
	for key, value in height.items():
		if value >=2:
			two_height.append(key)
	
	#print(two_height)
	print(len(two_height))
		
	
def point_on_line(line, point):
	a = (line[0], line[1])
	b = (line[2], line[3])
	c = point
	return math.isclose(math.dist(a,c) + math.dist(b,c), math.dist(a, b), rel_tol  = 10**(-9))


if __name__ == "__main__":
	main()