def main():
	lst = []
	while True:
		try:
			n = input().strip()
		except EOFError:
			break
		lst.append(n)
	
	relation = {}
	for open, close in zip("{([<})]>", "})]>{([<" ):
		relation[open] = close
	
	table = {}
	for key, value  in zip(")]}>", [3, 57, 1197, 25137]):
		table[key] = value
	
	table_two = {}
	for key, value  in zip(")]}>", [1,2,3,4]):
		table_two[key] = value
	
	open = "{([<"
	
	first_illegal = []
	non_err = []
	
	for line in lst:
		closer = []
		for symbol in line:
			if symbol in open:
				closer.append(relation[symbol])
			else:
				if symbol == closer[-1]:
					closer.pop()
				else:
					#print("error found. Exptected " +closer[-1] + ", but found "+ symbol)
					first_illegal.append(symbol)
					break
		non_err.append(line);

	non_error_fixed = []
	
	for line in non_err:
		closer = []
		for symbol in line:
			if symbol in open:
				closer.append(relation[symbol])
			else:
				if symbol == closer[-1]:
					closer.pop()
		non_error_fixed.append((line, closer));
	
	completions = ["".join(closer[::-1]) for s, closer in non_error_fixed]
	
	for open, close in zip(non_err,completions):
		print(open + close)
	
	scores = []
	for line in completions:
		score = 0
		for symbol in line:
			score *= 5
			score += table_two[symbol]
		scores.append(score)
	
	scores.sort()
	print(scores)
	print(scores[len(scores)// 2])
	
	
	


if __name__ == "__main__":
	main()
	
	
	
	
	
	
	
	
	