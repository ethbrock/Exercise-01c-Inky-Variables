/* ---------------------------------

THE REQUIREMENTS ARE AS FOLLOWS:
-4 or 8 Knots (watch video to confirm)
Two new variables through player choices
Print one of the variables in a passage
check a variable's value and have it do something

 ----------------------------------*/
 
 /* ---------------------------------

THE MAP:
            [A] - [B]
             |
[C] - [D] - [E] - [F]
       |     |
      [G] - [H]
      
A Bedroom
B Closet
C Bathroom
D Dining Room
E Living Room (Start)
F Kitchen
G Laundry Room
H Front Door

 ----------------------------------*/
 
/* ---------------------------------

TASKS:
-Pick up all the dirty clothes in the bedroom and take them to the Laundry Room <DONE?
-Get the broom from the closet and tidy every room (NEEDS TIDYING: C D F ) <DONE>
-Get food ready in the kitchen and bring it to the dining room
-Get Febreeze from Bathroom and spray down the stinky rooms (STINKY: A C E G ) <DONE>


WAYS TIME IS REDUCED:
-Doing an activity(variable)
-Moving through rooms(-1 min)

 ----------------------------------*/
 
/* ---------------------------------

TODO:
-Polish and descriptions for the various rooms

 ----------------------------------*/
 

Once upon a time, there was a house... but it was not a clean house! It was a dirty, dirty house, and it needed some heavy cleaning (as in, needed a few items put in the right spots). However, you only have a limited amount of time to clean it before your house guests arrive, so you need to spend your time wisely!

*Get started
    ->INSTRUCTIONS
VAR TimeLeft = 61
VAR RoomsFreshened = 0
VAR RoomsTidied = 0

==INSTRUCTIONS==
In order to properly get this house ready, you must complete the following tasks:
- Pick up all the dirty clothes in the bedroom and take them to the laundry room
- Get the broom from the closet and tidy the bathroom, dining room, and kitchen
- Get food ready in the kitchen and bring it to the dining room
- Get febreeze from the bathroom and spray down the bedroom, bathroom, living room and laundry room\

You will start in the living room. You have 60 minutes to get ready.
* Got it
  ->LIVING_ROOM

==BEDROOM==

{not FEBREEZE_BEDROOM and not PICKUP_DIRTY: Your bedroom is absolutely littered with your dirty clothes, and it stinks in here!}
{FEBREEZE_BEDROOM and not PICKUP_DIRTY: Your bedroom smells nice, but it's dirty in here!}
{not FEBREEZE_BEDROOM and PICKUP_DIRTY: Your bedroom is clean, but it smells in here!}
{FEBREEZE_BEDROOM and PICKUP_DIRTY: It's nice and clean in here!}
~ TimeLeft -= 1
{TimeLeft==0:->GAMEOVER}
You have {TimeLeft} minutes left!
+ Go to your closet
  ->CLOSET
+ Go to the living room
  ->LIVING_ROOM
* {FEBREEZE} Spray down the room
  ->FEBREEZE_BEDROOM
* Pick up all the dirty clothes
  ->PICKUP_DIRTY

==PICKUP_DIRTY==
  You pick up all your dirty clothes... it's a lot!
  ->BEDROOM

==FEBREEZE_BEDROOM==
~ RoomsFreshened += 1
  You spray febreeze around the room... ahh, so fresh!
  {RoomsFreshened!=4: Rooms freshened: {RoomsFreshened}/4}
  {RoomsFreshened==4: All rooms freshened! You discard the febreeze bottle.}
  ->BEDROOM


==CLOSET==
~ TimeLeft -= 1
{TimeLeft==0:->GAMEOVER}
You have {TimeLeft} minutes left!
+ Go back out to your bedroom
  ->BEDROOM
* Pick up broom
  ->BROOM
  
==BROOM==
  You pick up the broom... this could be used to tidy up some of the rooms!
  ->CLOSET
  
  
  
==BATHROOM==
{not TIDY_BATHROOM and not FEBREEZE_BATHROOM: This Bathroom is unrestrained! It is dirty and smelly in here!}
{TIDY_BATHROOM and not FEBREEZE_BATHROOM: This Bathroom is unrestrained, but better. It is very smelly in here!}
{not TIDY_BATHROOM and FEBREEZE_BATHROOM: This Bathroom is unrestrained, but a better. It is filthy in here!}
{TIDY_BATHROOM and FEBREEZE_BATHROOM: This Bathroom is now nice and clean!}
~ TimeLeft -= 1
{TimeLeft==0:->GAMEOVER}
You have {TimeLeft} minutes left!
+ Go back out to the dining room
  ->DINING_ROOM
* Grab the Febreeze
  ->FEBREEZE
* {FEBREEZE}: Spray down the room
  ->FEBREEZE_BATHROOM
* {BROOM}: Tidy up the room
  ->TIDY_BATHROOM
  
==TIDY_BATHROOM==
  You tidy up the room... looks nice and clean now!
~ RoomsTidied += 1
  {RoomsTidied!=3: Rooms tidied: {RoomsTidied}/3}
  {RoomsTidied==3: All rooms tidied! You put away the broom.}
  ->BATHROOM

==FEBREEZE==
  You grab the Febreeze... you can un-stink some of the rooms with this!
  ->BATHROOM

==FEBREEZE_BATHROOM==
~ RoomsFreshened += 1
  You spray febreeze around the room... ahh, so fresh!
  {RoomsFreshened!=4: Rooms freshened: {RoomsFreshened}/4}
  {RoomsFreshened==4: All rooms freshened! You discard the febreeze bottle.}
  ->BATHROOM
  

==DINING_ROOM==
{not TIDY_DINING_ROOM: The dining room is messy! | The dining room is clean!}
~ TimeLeft -= 1
{TimeLeft==0:->GAMEOVER}
You have {TimeLeft} minutes left!
+ Go into the bathroom
  ->BATHROOM
+ Go to the laundry room
  ->LAUNDRY_ROOM
+ Go to the living room
  ->LIVING_ROOM
* {BROOM}: Tidy up the room
  ->TIDY_DINING_ROOM
* {READY_FOOD}: Plate food
  ->PLATE_FOOD
  
==PLATE_FOOD==
You plate the food up... looks nice! The guests will like this. This task is finished!
  ->DINING_ROOM
  
==TIDY_DINING_ROOM==
  You tidy up the room... looks nice and clean now!
~ RoomsTidied += 1
  {RoomsTidied!=3: Rooms tidied: {RoomsTidied}/3}
  {RoomsTidied==3: All rooms tidied! You put away the broom.}
  ->DINING_ROOM
  


==LIVING_ROOM==
{not FEBREEZE_LIVING_ROOM: It stinks in here! | It smells much better in here!}
~ TimeLeft -= 1
{TimeLeft==0:->GAMEOVER}
You have {TimeLeft} minutes left!
+ Go to your bedroom
  ->BEDROOM
+ Go to the dining room
  ->DINING_ROOM
+ Go into the kitchen
  ->KITCHEN
+ Go to the front door
  ->FRONT_DOOR
* {FEBREEZE}: Spray down the room
  ->FEBREEZE_LIVING_ROOM

==FEBREEZE_LIVING_ROOM==
~ RoomsFreshened += 1
  You spray febreeze around the room... ahh, so fresh!
  {RoomsFreshened!=4: Rooms freshened: {RoomsFreshened}/4}
  {RoomsFreshened==4: All rooms freshened! You discard the febreeze bottle.}
  ->LIVING_ROOM
  


==KITCHEN==
{not TIDY_KITCHEN: It's filthy in here! | It's much cleaner in here now!}
~ TimeLeft -= 1
{TimeLeft==0:->GAMEOVER}
You have {TimeLeft} minutes left!
+ Go to the living room
  ->LIVING_ROOM
* {BROOM}: Tidy up the room
  ->TIDY_KITCHEN
* Get food ready
  ->READY_FOOD
  
==READY_FOOD==
  You get some food ready... it takes a while, but you get it done! You should deliver this to the dining room.
  ~ TimeLeft -= 4
    ->KITCHEN
  
==TIDY_KITCHEN==
  You tidy up the room... looks nice and clean now!
~ RoomsTidied += 1
  {RoomsTidied!=3: Rooms tidied: {RoomsTidied}/3}
  {RoomsTidied==3: All rooms tidied! You put away the broom.}
  ->KITCHEN

  

==LAUNDRY_ROOM==
{not FEBREEZE_LAUNDRY_ROOM: It smells in here! | It smells much better in here!}
~ TimeLeft -= 1
{TimeLeft==0:->GAMEOVER}
You have {TimeLeft} minutes left!
+ Go to the dining room
  ->DINING_ROOM
+ Go to the front door
  ->FRONT_DOOR
* {FEBREEZE}: Spray down the room
  ->FEBREEZE_LAUNDRY_ROOM
* {PICKUP_DIRTY}: Put dirty clothes away
  ->WASH_DIRTY

==WASH_DIRTY==
  You put your dirty clothes into the wash... that's one task down!
  ->LAUNDRY_ROOM

==FEBREEZE_LAUNDRY_ROOM==
~ RoomsFreshened += 1
  You spray febreeze around the room... ahh, so fresh!
  {RoomsFreshened!=4: Rooms freshened: {RoomsFreshened}/4}
  {RoomsFreshened==4: All rooms freshened! You discard the febreeze bottle.}
  ->LAUNDRY_ROOM
 

==FRONT_DOOR==
~ TimeLeft -= 1
You have {TimeLeft} minutes left!
+ Go to the living room
  ->LIVING_ROOM
+ Go to the laundry room
  ->LAUNDRY_ROOM
+ Check if you've done everything right
  ->CHECK_VICTORY


==CHECK_VICTORY==
  {PLATE_FOOD and WASH_DIRTY and RoomsFreshened == 4 and RoomsTidied == 3: Oh, yes! You did it! You did all the tasks! ->VICTORY | Oh, crap, you didn't do it all...}
  


==VICTORY==
Huzzah! You managed to get everything ready in time... and just before your guests arrive! They compliment how nice your place looks, and all of you enjoy a great dinner that night!
->END

==GAMEOVER==
  Oh no! You ran out of time, and now your guests are going to judge you for being sloppy... oh well.
  -> END
