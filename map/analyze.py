f = open("screen1.c","r")
text = f.read()
a = text.split("\n")[26:275]
c  = 0
outt=""

for bar in a:
	for i in bar.replace(" ","")[:-1].split(","):
		print(int(i,16),end="")
		outt+=str(int(i,16))
		c = c +1
	if c>49:
		outt+="|"
		print("|\n",end="") # for some reason, bottom row of the map does not load in all the way. idk why.
		c = 0
f.close()

f2 = open("screen1.txt","w")
f2.write(outt)
f2.close()
