def main():
	lst = []
	while True:
		try:
			n = input().strip()
		except EOFError:
			break
		lst.append(n)
	
	map = {}
	for row in range(len(lst)):
		for col in range(0,len(lst[0])):
			map[(row,col)] = int(lst[row][col])
			
	low_points = []
	for pos, depth in map.items():
		if lower_then_adjacent(pos, map):
			low_points.append(depth)
	

	print(sum(low_points, len(low_points)))

def lower_then_adjacent(p, map):
		itself = map[(p[0], p[1])]
		up, down, left, right = 110, 110, 110, 110
		
		try: 
			up = map[(p[0]+1, p[1])]
		except: 
			pass
		try: 
			down = map[(p[0]-1, p[1])] 
		except: 
			pass		
		try: 
			left = map[(p[0], p[1]+1)]
		except: 
			pass
		try: 
			right = map[(p[0], p[1]-1)] 
		except: 
			pass	
		
		if itself >= up: return False
		if itself >= down: return False
		if itself >= left: return False
		if itself >= right: return False
		
		return True
	
	
	
	
	
	


if __name__ == "__main__":
	main()