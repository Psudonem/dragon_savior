I'm not sure if this is how you format this readme but here goes.\
NOTE: This project is written in QB64. The C files are hold over from GBMB, and I use the analyze.py program to convert them into BASIC code.


Update 1:49 AM 12/30/2022

I've implamented a lot of the features I wanted to implament, but the game feels like it's missing something. What do you do when the game's main idea isn't as fun as you'd hoped?
Something to think about. I know this was a big problem with deus ex for wii u. I don't remember the title, but when those guys in montreal were developing it, they made the whole thing on paper first and made it directly to the spec. Now that game's fun but it could deffo be better, and I remember that being a common sentiment. I did somethnig similar with this game, and while it does have some fun elements, I feel like i'm missing something. Maybe I should remove the power meter? or maybe it's time for a second opinion

Done:

- enemies and projectiles hurt the player
- you can kill enemies with fireballs

Todo:

- non killable level hazards (so u can't just spray the whole screen full of shit)
- mutiple levels.. or one really big level?
- death screen/game over
- win/lose state
- give player a way to refuel health. should it be at the end of the level or in the form of an item? i made a burger sprite but i fear it's not 
- do we really need power/stamina? if the goal is to kill all the enemies then maybe this is extra level of challenge is too much for a simple arcade game
- sfx/music/polish


What do you think?
I want to finish five games like this before school starts back up, but I also don't want to half ass this, especially since it's such a simple concept.

I'll think about this further.




Update 9:28 PM 12/29/2022

I'll keep this breif.
- added health 
- made the enemies "shoot projectiles" (they don't move yet"
- made some prototypes for the game over screen (see the new png)
- picked the perfect game over song (not in the files yet, you'll see it soon)


todo
- first marching order, make the blobs shoot. preferably at the player. lower the fire rate so it's not so hectic
- everything else
- the graphic for the projectile is pretty unclear
- note to self: 
	eating an enemy does -2 hp and recovers one stamina
	taking an enemy hit does -1 hp




Update 7:56 PM 12/29/2022

Accomplished a lot today. not done for the day but I thought I'd update the repo with the current progress.

Consider it a personal 'stand up' meeting from me to you

What I've accomplished so far:
- modularized assets are almost fully worked in
- enemies move around! not smartly, but they move!
- shooty fireballs (no stamina yet)
- sfx for fireball, and killing enemy


Todo
- intellegent enemy AI
- enemies that throw things at the player
- everything pertaining to player health
- game over/death condition
- next levels
- ending screen
- explain the controls in game!!!!!!!!!!!!!!!!!!!!!!!!
- explain the lore in game!!!!!!!!!!!!!!
- fix game music

non priority todo:
- new enemy type? something non killable to keep the player guessing, maybe a spike that oscilates back and forth between screens...

The difference between yesterday and today is pretty staggering. Stay tuned for an update later tonight!


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