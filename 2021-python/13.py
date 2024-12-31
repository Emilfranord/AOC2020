def main():
	lst = []
	while True:
		try:
			n = input().strip()
		except EOFError:
			break
		lst.append(n)

	points = []
	folds = []
	for value in lst:
		if "fold" in value:
			folds.append((value.split(" ")[2].split("=")))
			
		elif "," in value:
			points.append((int(value.split(",")[0]), int(value.split(",")[1])))

	
	for value in folds:
		new_points = []
		axis, fold = value
		fold = int(fold)
		x, y = point
		if axis == "y":
			for point in points:
				new_points.append((x, fold - abs(fold - y)))
		if axis == "x":
			for point in points:
				new_points.append((fold - abs(fold - x), y))
		points = set(new_points)
		
	
	print(len(set(new_points)))
	new_points.sort()
	# rather than printing the answer to stdout, we pipe it to a file, and use desmos to display the points.
	f = open("13out.txt", "a")
	for pair in set(new_points):
		f.write(str(pair)+"\n")
	f.close

if __name__ == "__main__":
	main()