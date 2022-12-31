f = open("screen1.c","r")
text = f.read()
a = text.split("\n")[26:275]
c  = 0
outt="level1:\n\n"

total = 0 
for bar in a:
	print("\nDATA ", end ="")
	outt +="\nDATA "
	for n,i in enumerate(bar.replace(" ","")[:-1].split(",")):
		print(str(int(i,16)),end="")
		outt+=str(int(i,16))
		c = c +1
		total+=1
		if n<9:
			print(",",end="")
			outt+=","
		else:
			print("")

	if c>49:
		#outt+="|"
		#print("|",end="") # for some reason, bottom row of the map does not load in all the way. idk why.
		c = 0
f.close()
outt+="\nDATA "+(100*"0,")[:-1]
f2 = open("..\world.bas","w")
f2.write(outt)
f2.close()



f = open("screen2.c","r")
text = f.read()
a = text.split("\n")[26:275]
c  = 0
outt="level2:\n\n"

total = 0 
for bar in a:
	print("\nDATA ", end ="")
	outt +="\nDATA "
	for n,i in enumerate(bar.replace(" ","")[:-1].split(",")):
		print(str(int(i,16)),end="")
		outt+=str(int(i,16))
		c = c +1
		total+=1
		if n<9:
			print(",",end="")
			outt+=","
		else:
			print("")

	if c>49:
		#outt+="|"
		#print("|",end="") # for some reason, bottom row of the map does not load in all the way. idk why.
		c = 0
f.close()
outt+="\nDATA "+(100*"0,")[:-1]
f2 = open("..\world2.bas","w")
f2.write(outt)
f2.close()



f = open("screen3.c","r")
text = f.read()
a = text.split("\n")[26:275]
c  = 0
outt="level3:\n\n"

total = 0 
for bar in a:
	print("\nDATA ", end ="")
	outt +="\nDATA "
	for n,i in enumerate(bar.replace(" ","")[:-1].split(",")):
		print(str(int(i,16)),end="")
		outt+=str(int(i,16))
		c = c +1
		total+=1
		if n<9:
			print(",",end="")
			outt+=","
		else:
			print("")

	if c>49:
		#outt+="|"
		#print("|",end="") # for some reason, bottom row of the map does not load in all the way. idk why.
		c = 0
f.close()
outt+="\nDATA "+(100*"0,")[:-1]
f2 = open("..\world3.bas","w")
f2.write(outt)
f2.close()
