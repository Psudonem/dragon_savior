f = open("screen1.c","r")
text = f.read()
a = text.split("\n")[26:275]
c  = 0
for bar in a:
	for i in bar.replace(" ","")[:-1].split(","):
		print(int(i,16),end="")
		c = c +1
	if c>49:
		print("\n")
		c = 0