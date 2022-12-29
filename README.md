I'm not sure if this is how you format this readme but here goes.\
NOTE: This project is written in QB64. The C files are hold over from GBMB, and I use the analyze.py program to convert them into BASIC code.


Update 1:17 AM 12/28/2022

Pretty big update here! 
alright so here's what I've done:
dragon_savior.exe
- title screen!

test.exe (for working out all the ideas before working them into the main EXE)
- actual graphics! <<-  mostly done!
- sound effects! <<- very important!
- background music! (it's a little loud! so if you run the EXE in its current state, please turn your audio down)
- can pick up money and open doors! 
- side menu objects outlined

what i learned:
- game assets can be stored in user defined types, makes things easier to organize
- the background music is kinda annoying. i'll take off the bell and turn it down in the next iteration
- now i see why most games aren't grid based like this. it's pretty awkward to play at times


what still needs to be done:
- need need need to modularize game assets (as in, store live objects on multiple planes), so that it's easier to organize and work with them. Avoid page flipping arrays. it will make things easier for all of us
- enemies that move around (should I do a write up on the ai?)
- shooty fire balls from dragon with stamina that slowly replenishes
- health points
- health upgrade item? could be cool to implament
- next levels
- ending screen
- explain the controls in game!!!!!!!!!!!!!!!!!!!!!!!!
- explain the lore in game!!!!!!!!!!!!!!


Update 3:58 AM 12/27/2022

wrote the design doc. see dragonS_designdoc_1 and 2 images to get a feel for what kind of game I'm trying to make.
please excuse my chicken scratch hehehe

Update 8:29 PM 12/26/2022

test.exe shows a fully loaded up game. woohoO! We have movement, and we can load in maps with a spawn point. No sprite graphics yet. I want to make sure the basic gameplay is there first before we do anything crazy with the graphics. I did write music tho (go figure). I'll post that in the next update.

also! controls are wasd, and q to quit.

Update 4:17 AM 12/26/2022 - 

OK. i think i'm going to call it. We can read data from the text file and display it on the screen but there seems to be some sort of issue in the read process.
Pipeline is alter map in GBMB, Export
Oh! Also gogo updates the repo.

Update 3:33 AM EST 12/26/2022 -
made a simple map, doing some conversion scripting in python
not sure what lang to code the actual game in. for now, im gonna convert the map into a log ass string. strings are easy to read right? I'll parse that string into an array, and then use the array to render the graphics with.

Update 12-26-2022, 3:03 AM EST - 
The goal is to create a clone of Falcom's Dragon Slayer.  I need to refine the gameplay a bit before I fully put it into code. I might have to use game maker 7 for that.