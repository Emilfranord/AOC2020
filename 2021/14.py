def main():
	
	lst = []
	while True:
		try:
			n = input().strip()
		except EOFError:
			break
		lst.append(n)
	
	word = lst[0]
	productions = {}
	for index in range(2,len(lst)):
		inp, output = lst[index].split(" -> ")
		output = inp[0] + output #+ inp[1]
		productions[inp] = output
	
	for time in range(0,40):
		build = []
		print(time)
		for index in range(0, len(word)-1):
			build.append(productions[word[index] + word[index+1]])
		build.append(word[-1])
		word = "".join(build)
	
	counting = {}
	for value in productions.values():
		counting[value[1]] = 0
	
	for symbol in word:
		counting[symbol] += 1
 
	print(max(counting.values()) - min(counting.values()))


if __name__ == "__main__":
	main()