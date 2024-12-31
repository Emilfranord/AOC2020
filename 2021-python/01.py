def main():
	lst = []          
	while True:
		try:
			n = int(input())
		except EOFError:
			break
		lst.append(n)
	
	past = 0;
	count = 0; 
	for index in range(len(lst)-3):
		first_win = lst[index] +lst[index+1] + lst[index+2]
		second_win = lst[index+1] +lst[index+2] +lst[index+3]
		if first_win < second_win:
			count = count +1

	print(count)




if __name__ == "__main__":
	main()