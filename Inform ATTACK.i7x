Version 3 of Inform ATTACK by Victor Gijsbers begins here.



Volume - Inclusions, programming variables and tricks

Include Inform ATTACK Core by Victor Gijsbers.

Include Plurality by Emily Short.

To decide which number is the current_row: (- ct_1 -).



Volume - Changes to be integrated

[see section on natural weapons]
A starting the combat round rule (this is the ready natural weapons rule):
	ready natural weapons.




Volume - The Main System

[The Main System covers the basics of combat, and creates rulebooks for all other systems to fit into.]


Book - Minor Preliminaries


[Chapter - Saying things

[This variable determines whether we get to see numerical output.]

The numbers boolean is a truth state that varies. The numbers boolean is usually true.

Switching the numbers off is an action out of world. Understand "numbers off" as switching the numbers off.

Carry out switching the numbers off (this is the standard switching the numbers off rule):
	take no time;
	now the numbers boolean is false;
	say "You will no longer see combat-related numbers.".

Switching the numbers on is an action out of world. Understand "numbers on" as switching the numbers on.

Carry out switching the numbers on (this is the standard switching the numbers on rule):
	take no time;
	now the numbers boolean is true;
	say "You will now see combat-related numbers.".]



[I want "you", not "yourself".]

Rule for printing the name of yourself (this is the standard yourself to you rule):
	say "you".

[But we'll need to have tokens that print "You" rather than "you". For this reason, the following.]

[Before printing the name of the global attacker or the global defender or the global actor or the noun or the second noun (this is the global attacker etc name printing rule):
	now yourself to you is true;]

To say CAP-attacker:
	if the global attacker is the player begin;
		say "[The global attacker]" in sentence case;
	otherwise;
		say "[The global attacker]";
	end if.

To say CAP-defender:
	if the global defender is the player begin;
		say "[The global defender]" in sentence case;
	otherwise;
		say "[The global defender]";
	end if.

The global actor is a person that varies.

To say CAP-actor:
	if the global actor is the player begin;
		say "[The global actor]" in sentence case;
	otherwise;
		say "[The global actor]";
	end if.

To say CAP-noun:
	if the noun is the player begin;
		say "[The noun]" in sentence case;
	otherwise;
		say "[The noun]";
	end if.

To say CAP-second noun:
	if the second noun is the player begin;
		say "[The second noun]" in sentence case;
	otherwise;
		say "[The second noun]";
	end if.



Chapter - Time

[Some of the actions should take no time; we wish to ensure that examining, smelling, and so on do not take a combat turn. This will allow the player to look around in combat, which is to be encouraged.]

[Section - Examining is fast

Examining something is acting fast.

Section - Taking inventory is fast

Taking inventory is acting fast.

Section - Smelling is fast

Smelling is acting fast.

Section - Smelling something is fast

Smelling something is acting fast.

Section - Looking is fast

Looking is acting fast.

Section - Looking under is fast

Looking under something is acting fast.

Section - Listening is fast

Listening is acting fast.

Section - Listening to is fast

Listening to something is acting fast.

Section - Thinking is fast

Thinking is acting fast.

Section - Out of game is fast

Quitting the game is acting fast.
Saving the game is acting fast.
Restoring the game is acting fast.
Restarting the game is acting fast.
Verifying the story file is acting fast.
Switching the story transcript on is acting fast.
Switching the story transcript off is acting fast.
Requesting the story file version is acting fast.
Requesting the score is acting fast.
Preferring abbreviated room descriptions is acting fast.
Preferring unabbreviated room descriptions is acting fast.
Preferring sometimes abbreviated room descriptions is acting fast.
Switching score notification on is acting fast.
Switching score notification off is acting fast.
Requesting the pronoun meanings is acting fast.]

[The take no time boolean is a truth state that varies. The take no time boolean is false.

[There are two ways to set the take no time boolean: by declaring an action acting fast, or by hand, by saying "take no time".]]

[Rule for setting action variables when acting fast:
	now the take no time boolean is true.]

[The just moved boolean is a truth state that varies. The just moved boolean is false. [Please do not use this boolean yourself.]

After going (this is the first make sure that going is not acting fast rule):
	now the just moved boolean is true;
	continue the action.

After looking (this is the second make sure that going is not acting fast rule):
	if the just moved boolean is true:	
		now the take no time boolean is false;
		now the just moved boolean is false;
	continue the action.
	
After looking for the first time (this is the looking at the beginning of the game is not acting fast rule):
	now the take no time boolean is false;
	continue the action.]

[To take no time:
	now the take no time boolean is true.

To say take no time:
	take no time.]

[This is the acting fast rule: [Stops the turn sequence rules before we reach the every turn rules.]
	if the take no time boolean is true:
		rule succeeds.
		
The acting fast rule is listed before the every turn stage rule in the turn sequence rules.


This is the reset take no time boolean rule: [We must reset the boolean, of course.]
	now the take no time boolean is false.
	
The reset take no time boolean rule is listed before the generate action rule in the turn sequence rules.]


Book - Dressing up the Person Class

Chapter - Health

[A person has a number called health. The health of a person is usually 10. [health is a measure of health.]

Definition: A person is alive if its health is 1 or more. Definition: A person is killed if its health is 0 or less. [Once health drops to zero, you are dead. This holds true for both the player and his enemies.]

The printing dead property is a truth state that varies.
The printing dead property is true.

To say no dead property:
	now the printing dead property is false.

To say dead property:
	now the printing dead property is true.

Before printing the name of a killed person (called body) (this is the improper print dead property rule):
	if the printing dead property is true:
		if body is improper-named:
			say "dead [run paragraph on]".

After printing the name of a killed person (called body) (this is the proper print dead property rule):
	if the printing dead property is true:
		if body is proper-named:
			say "'s [if body is plural-named]bodies[otherwise]body[end if]".


Understand "dead" as a person when the item described is killed.
Understand "killed" as a person when the item described is killed.
Understand "body" as a person when the item described is killed.
Understand "body of" as a person when the item described is killed.
Understand "bodies" as a person when the item described is killed.
Understand "bodies of" as a person when the item described is killed.
Understand "corpse" as a person when the item described is killed.
Understand "alive" as a person when the item described is alive.
Understand "live" as a person when the item described is alive.
Understand "living" as a person when the item described is alive.
[Understand "[something related by equality]'s" as a person.] [Doesn't work, unfortunately.]]



[To make looting possible.]

The can't take people's possessions rule is not listed in any rulebook.

Check an actor taking (this is the can't take living people's possessions rule):
	let the local ceiling be the common ancestor of the actor with the noun;
	let H be the not-counting-parts holder of the noun;
	while H is not nothing and H is not the local ceiling:
		if H is an alive person, stop the action with library message taking action
			number 6 for H;
		let H be the not-counting-parts holder of H;

After examining a killed person (this is the give list of possession on dead person rule):
	if the number of things carried by the noun is at least one:
		say "On the [if the noun is plural-named]bodies[otherwise]body[end if] of [the noun] you also see [list of things carried by the noun with indefinite articles].".



A person has a number called permanent health. [The maximum you can regain with healing.]

When play begins (this is the set permanent health to initial health rule):
    repeat with the patient running through people begin;
        change the permanent health of the patient to the health of the patient;
    end repeat.

[We set the permanent health of each individual to the health it has at the beginning of the game. If we wish any character to start the game wounded or super-healthy, we will have to manually override this process.]

To restore the health of (patient - a person): change the health of the patient to the permanent health of the patient. 

To fully heal (patient - a person):
	if the permanent health of the patient is greater than the health of the patient:
		restore the health of the patient.

The healed amount is a number that varies. The healed amount is usually 0.

To heal (patient - a person) for (health - a number) health:
	let the health dummy be the permanent health of the patient minus the health of the patient;
	if health is less than the health dummy, now the health dummy is health;
	if the health dummy is less than 0, now the health dummy is 0;
	increase the health of the patient by the health dummy;
	now the healed amount is the health dummy. [For storage.]




Chapter - Basic Combat Stats

[Melee is a measure of fighting prowess. Higher melee means higher chance to hit.]

A person has a number called melee. The melee of a person is usually 0. 

[Defence is a measure of fighting prowess. Higher defence means less chance to get hit.]

A person has a number called defence. The defence of a person is usually 7.




[Chapter - Factions

[Now we define factions. Everyone should belong to a faction. You can add as many factions as you like!]

Faction is a kind of value. The factions are friendly, passive and hostile.


[Now we define a relation between factions which indicates whether these factions will attack each other.]

Hating relates factions to each other. 

The verb to hate (he hates, they hate, he hated, it is hated, he is hating) implies the hating relation.

Friendly hates hostile. Hostile hates friendly.

A person has a faction. A person is usually passive.

The player is friendly.



[Now we need a phrase to decide whether people are going to battle each other in the current location. If not, we're not going to run all our ATTACK-machinery.]

The hate rules are a rulebook.	

To decide whether hate is present:
	consider the hate rules;
	if rule succeeded:
		decide yes;
	otherwise:
		decide no.

Last hate rule (this is the standard hate rule):
	if the player is friendly and at least one hostile alive person is enclosed by the location:
		if friendly hates hostile:
			rule succeeds; [This is only here for speed. It is the most common case where we decide yes.]
	repeat with X running through alive not passive persons enclosed by the location:
		repeat with Y running through alive persons enclosed by the location:
			if the faction of X hates the faction of Y:
				rule succeeds;
	rule fails.]
	


Book - Combat Round

[Chapter - Combat States

[A person can have four combat states: Normal, Act, React and Reacted.

Normal: not doing anything in the current round.
Act: the one whose turn it is.
React: this person will be called on to react to the current action.
Reacted: this person has declared a reaction to the current action.]

Combat state is a kind of value. The combat states are at-Normal, at-Act, at-React and at-Reacted.

A person has a combat state. The combat state of a person is usually at-Normal.]

A person has a person called the provoker.
A person has an action-name called the provocation.


Chapter - Setting up the Combat Order

Section - Initiative

[The person with the highest initiative is the one whose turn it is.]

[A person has a number called the initiative. The initiative of a person is usually 0.

The initiative rules are a rulebook.

First initiative rule (this is the no low initiative trap rule):
	repeat with X running through all alive persons enclosed by the location:				
		if the initiative of X is less than -2, now the initiative of X is -2.
		
Initiative rule (this is the increase initiative every round rule):
	repeat with X running through all alive persons enclosed by the location:
		increase the initiative of X by 2.
	
Initiative rule (this is the random initiative rule):
	repeat with X running through all alive persons enclosed by the location:				
		increase the initiative of X by a random number between 0 and 2.]

An aftereffects rule (this is the modify initiative based on combat results rule):
	if the final damage is greater than 0 begin;
		decrease the initiative of the global defender by 2;
	otherwise;
		decrease the initiative of the global attacker by 2;
	end if.


Section - Deciding the order

[Table of Combat Order
Combatant	       Move Order
a person			a number
with 20 blank rows

To set up the combat order:
	consider the initiative rules;
	repeat through the Table of Combat Order:
		blank out the whole row;
	repeat with X running through all alive not passive persons enclosed by the location:
		choose a blank row in Table of Combat Order;
		now the Combatant entry is X;
		now the Move Order entry is the initiative of X;
		[say "[X]: [Move Order entry] "; [Use this for testing initiative rules.]]
		now the combat state of X is at-Normal;
	sort the Table of Combat Order in random order;
	sort the Table of Combat Order in reverse Move Order order.]

[When play begins (this is the set up the combat order when play begins rule):
	set up the combat order.]



Chapter - The actual combat round

[The main actor is a person that varies. [MANUAL]]

Section - Main combat round routines


[This is the govern combat first part rule:
	if the take no time boolean is false:
		change the command prompt to ">";
		repeat with X running through all alive persons enclosed by the location:
			now the combat state of X is at-Normal;
		if hate is present:
			ready natural weapons; [see section on natural weapons]
			set up the combat order;
			handle the combat round;
		otherwise:
			now the main actor is the player.
			
The govern combat first part rule is listed before the parse command rule in the turn sequence rules.]
	

[This is the govern combat second part rule:
	if the take no time boolean is false:
		if the combat state of the player is at-React, now the combat state of the player is at-Reacted;
		have a reaction;
		run the combat.

The govern combat second part rule is listed before the acting fast rule in the turn sequence rules.]


[This is the dont parse command when not the players turn rule:
[	if hate is present:
		if the combat state of the player is at-Normal:
			if the take no time boolean is false:
				stop the parser from running;]
	if the main actor is not the player and the combat state of the player is not at-React:   [NEW: make sure it doesn't introduce bugs!!]
		stop the parser from running.

To stop the parser from running: (- EarlyInTurnSequence = false; -).

The dont parse command when not the players turn rule is listed before the parse command rule in the turn sequence rules.]


Section - Handling the combat round

[The starting the combat round rules are a rulebook.]

[To handle the combat round:
	choose row 1 in the Table of Combat Order;
	now the global attacker is the combatant entry;
	now the initiative of the global attacker is 0;
	now the combat state of the global attacker is at-Act;
	now the main actor is the global attacker;
	consider the starting the combat round rules;
	if the global attacker is the player:
		change the command prompt to "Act>";
		stop;
	if the global attacker is alive, consider the combat AI rulebook of the global attacker;
	if the combat state of the player is at-React:
		change the command prompt to "React>";
		stop.]


Section - Having a reaction

[To have a reaction:
	repeat with N running from 1 to the number of rows in the Table of Combat Order:
		choose row N in the Table of Combat Order;
		if there is combatant in row N of the Table of Combat Order:
			if the combat state of the combatant entry is at-React:
				now the global attacker is the combatant entry;
				if the global attacker is alive, consider the combat AI rulebook of the global attacker;
				now the combat state of the global attacker is at-Reacted.]


Section - Running the combat

[The fight consequences variable is a truth state that varies. The fight consequences variable is false.

Table of Stored Combat Actions
Combat Speed		Combat Action
a number				a stored action
with 20 blank rows

To run the combat:
	now the fight consequences variable is true;
	sort the Table of Stored Combat Actions in Combat Speed order;
	repeat through the Table of Stored Combat Actions:
		try the Combat Action entry;
		blank out the whole row;
	now the fight consequences variable is false.]







Book - Striking a Blow



Chapter - Striking a blow

The global attacker is a person that varies.
The global defender is a person that varies.

A weapon is a kind of thing. A weapon is either readied or not readied. A weapon is usually not readied.

The global attacker weapon is a weapon that varies.
The global defender weapon is a weapon that varies.

The to-hit roll is a number that varies. The to-hit modifier is a number that varies. The damage is a number that varies. The damage modifier is a number that varies. The final damage is a number that varies.

The reset combat variables is a rulebook.
The whether attacking begins is a rulebook.
The preliminary results of attacking is a rulebook.
The basic attack roll is a rulebook.
The attack modifiers is a rulebook.
The calculate results of the attack roll is a rulebook.
The show results of the attack roll is a rulebook.
The whether the attack hit is a rulebook.
The immediate results of hitting is a rulebook.
The basic damage roll is a rulebook.
The damage modifiers is a rulebook.
The calculate the final damage rules is a rulebook.
The show the final damage rules is a rulebook.
The aftereffects before flavour text is a rulebook.
The print flavour text is a rulebook.
The aftereffects is a rulebook.
The take away until attack circumstances is a rulebook.
The final blow report is a rulebook.

To make (attacker - a person) strike a blow against (defender - a person):
	now the global attacker is the attacker;
	now the global defender is the defender;
	have the global attacker start pressing the global defender;
	now the global attacker weapon is a random readied weapon enclosed by the global attacker;
	now the global defender weapon is a random readied weapon enclosed by the global defender;
	consider the reset combat variables rules;
	consider the whether attacking begins rules; [Stage 1: Whether attacking begins]
	if rule failed:
		consider the take away until attack circumstances rulebook;
		rule fails;
	consider the preliminary results of attacking rules; [Stage 2: Preliminary results of attacking]
	consider the basic attack roll rules; [Stage 3: Basic attack roll]
	consider the attack modifiers rules; [Stage 4: Apply attack modifiers]
	consider the calculate results of the attack roll rules; [Stage 5: calculate results of the attack roll]
	consider the show results of the attack roll rules; [Stage 6: calculate results of the attack roll] [TEST: ; -> ., check whether new Inform still crashes]
	consider the whether the attack hit rules; [Stage 7: check and report whether we hit]
	if rule succeeded:
		abide by the immediate results of hitting rules; [Stage 8: stage for some special effects]
		consider the basic damage roll rules; [Stage 9: roll the die for damage]
		consider the damage modifiers rules; [Stage 10: add or subtract modifiers]
		consider the calculate the final damage rules; [Stage 11: calculate final damage]
		consider the show the final damage rules; [Stage 12: print the damage]
	consider the aftereffects before flavour text rulebook; [Stage 13: anything that must happen before flavour text is printed.]
	consider the print flavour text rules; [Stage 14: flavour text]
	if the player is not killed, consider the aftereffects rulebook; [Stage 15: aftereffects]
	consider the take away until attack circumstances rulebook; [Stage 16: taking away anything that lasts until you have attacked]
	consider the final blow report rulebook. [Stage 17: any reporting left to be done]


Section - Reset combat variables

A reset combat variables rule (this is the standard reset combat variables rule):
	now the damage is 0; 
	now the final damage is 0;
	now the to-hit roll is 0;
	now the to-hit modifier is 0;
	now the damage modifier is 0.


Section - Basic attack roll

A basic attack roll rule (this is the standard attack roll rule):
	if the numbers boolean is true, say "[italic type]Rolling ";
	change the to-hit roll to a random number between 1 and 10;
	if the numbers boolean is true, say the to-hit roll, "[run paragraph on]".


Section - Attack modifier melee

An attack modifiers rule (this is the melee attack bonus rule):
	if the numbers boolean is true and the melee of the global attacker is not 0:
		if the melee of the global attacker is greater than 0:
			say " + ", the melee of the global attacker, " (inherent bonus)[run paragraph on]";
		otherwise:
			say " - ", 0 minus the melee of the global attacker, " (inherent penalty)[run paragraph on]";
	increase the to-hit modifier by the melee of the global attacker.


Section - Calculate results of attack roll

A calculate results of the attack roll rule (this is the standard calculate results of the attack roll rule):
	increase the to-hit roll by the to-hit modifier.


Section - Show results of attack roll

A show results of the attack roll rule (this is the standard show results of the attack roll rule): 
	if the numbers boolean is true, say " = ", the to-hit roll, ", [run paragraph on]".

Section - Whether the attack hits

A whether the attack hit rule (this is the standard whether the attack hit rule):
	if the to-hit roll is greater than the defence of the global defender begin;
		if the numbers boolean is true begin;
			if the global attacker is the player, say "you beat "; otherwise say "[the global attacker] beats ";
			say "[possessive of global defender] defence rating of ", the defence of the global defender, ".";
		end if;
		rule succeeds;
	otherwise;
		if the numbers boolean is true begin;
			if the global attacker is the player, say "you do ";
			if the global attacker is not the player, say "[the global attacker] does ";
			say "not overcome [possessive of global defender] defence rating of ", the defence of the global defender, "[roman type].";
		end if;
		rule fails;
	end if.

Section - Basic damage roll

First basic damage roll rule (this is the standard damage roll rule):
	now damage is 0;
	unless damage die of the global attacker weapon is less than 1:
		now the damage is a random number between 1 and the damage die of the global attacker weapon;
	increase damage by weapon damage bonus of the global attacker weapon; [1d(damage die) + WDB]
	if the numbers boolean is true:
		if the global attacker is the player, say "You deal ", damage, "[run paragraph on]";
		if the global attacker is not the player, say "[The global attacker] deals ", damage, "[run paragraph on]".



Section - Calculating the final damage

Calculate the final damage rule (this is the standard calculate the final damage rule):
	now the final damage is the damage plus the damage modifier;
	if the final damage is less than 0, now the final damage is 0.
	
	
Section - Showing the final damage

Show the final damage rule (this is the standard show the final damage rule):
	if the numbers boolean is true, say " = [bold type]", final damage, " damage[roman type][italic type], [run paragraph on]".

Last show the final damage rule (this is the standard report result of blow in numbers mode rule):
	if the numbers boolean is true:
		if the final damage is less than 1: [no damage]
			if the global defender is not the player, say "allowing [the global defender] to escape unscathed.[run paragraph on]";
			if the global defender is the player, say "allowing you to escape unscathed.[run paragraph on]";
		otherwise:
			if the final damage is less than the health of the global defender: [non-fatal]
				if the global defender is not the player, say "wounding [the global defender] to ", health of the global defender minus final damage, " health.[run paragraph on]" ;
				if the global defender is the player, say "wounding you to ", health of the global defender minus final damage, " health.[run paragraph on]";
			otherwise: [fatal]
				if the global defender is not the player:
					if the numbers boolean is true, say "killing [no dead property][the global defender][dead property].[run paragraph on]";
				otherwise:
					if the numbers boolean is true, say "killing you.";
		say "[roman type][paragraph break]".


Section - Aftereffects before flavour text

Aftereffects before flavour text (this is the subtract damage from health rule):
	decrease the health of the global defender by the final damage.


Section - Flavour text rules

The intervening flavour text are a rulebook. [Use this to intervene in the normal procedure.]
The flavour are a rulebook. [In non-fatal cases]
The fatal player flavour are a rulebook. [When the player is killed.]
The fatal flavour are a rulebook. [When someone else is killed.]

The attack move flavour are a rulebook. [When someone attacks, before the other person reacts.]

A print flavour text rule (this is the flavour text structure rule):
	abide by the intervening flavour text rules;
	if the global defender is alive:
		consider the flavour rulebook;
	otherwise:
		if the global defender is the player, consider the fatal player flavour rulebook;
		if the global defender is not the player, consider the fatal flavour rulebook.

Last flavour rule (this is the basic flavour rule):
	if the final damage is greater than 0:
		say "[CAP-attacker] hit[s] [the global defender].[run paragraph on]";
	otherwise:
		say "[CAP-attacker] miss[es] [the global defender].[run paragraph on]";
	continue the action.

Last fatal player flavour rule (this is the basic fatal player flavour rule):
	say "You are killed by [no dead property][the global attacker][dead property].".

Last fatal flavour rule (this is the basic fatal flavour rule):
	say "[CAP-attacker] kill[s] [no dead property][the global defender][dead property].".

Last attack move flavour rule (this is the basic attack move flavour rule):
	now the global actor is the actor;
	if the actor is not the player, say "[CAP-actor] lung[es] towards [the noun].[paragraph break]".
	
Section - Aftereffects

An aftereffects rule (this is the unready weapons of dead person rule):
	if the global defender is killed:
		repeat with X running through weapons enclosed by the global defender:
			now X is not readied.

Section - Final blow report

Last final blow report rule (this is the end reporting blow with paragraph break rule):
	say "[paragraph break]".




Book - Standard Combat Actions

[Chapter - Waiting

Carry out an actor waiting (this is the waiting lets someone else go first rule):
	if the combat state of the actor is at-Act:
		let Y be 0;
		repeat with X running through all alive persons enclosed by the location:
			if X is not the actor:
				if the initiative of X is greater than Y, now Y is the initiative of X;
		now the initiative of the actor is Y - 2.

[Last report an actor waiting:
	if the actor is not the player:
		say "[CAP-actor] wait[s].".]]



Chapter - Attacking

The block attacking rule is not listed in any rulebook.

Understand "a [thing]" as attacking.

Does the player mean attacking a killed person: it is unlikely.
Does the player mean attacking a person:
	if the faction of the player hates the faction of the noun:
		it is very likely.
[Does the player mean attacking a hostile alive person: it is likely.]

A check attacking rule (this is the only attack persons rule):
	if the noun is not a person:
		take no time;
		say "Things are not your enemies." instead.

A check attacking rule (this is the only attack the living rule):
	if the noun is not alive:
		take no time;	
		say "[The noun] is already dead." instead.

A check attacking rule (this is the do not kill yourself rule):
	if the noun is the player:
		take no time;
		say "You are not that desperate!" instead.

A check attacking rule (this is the do not attack friendly people rule):
	if the faction of the player is the faction of the noun:
		take no time;
		say "[The noun] is your friend, not your enemy!" instead.

A check attacking rule (this is the do not attack neutral people rule):
	if the faction of the player does not hate the faction of the noun:
		take no time;
		say "[The noun] is not your enemy." instead.

A check attacking rule (this is the cannot attack as reaction rule):
	if the combat state of the player is at-React:
		take no time;
		say "Attacking is an action, not a reaction." instead.

Carry out an actor attacking when the fight consequences variable is false (this is the standard active attacking first phase rule):
	if the combat state of the actor is at-Act:
		now the global attacker is the actor;
		now the global attacker weapon is a random readied weapon enclosed by the global attacker;
		consider the attack move flavour rulebook;
		choose a blank row in the Table of Stored Combat actions;
		now the Combat Speed entry is 10;
		now the Combat Action entry is the action of the actor attacking the noun;
		now the combat state of the noun is at-React;
		now the provoker of the noun is the actor;
		now the provocation of the noun is the attacking action.

Carry out an actor attacking when the fight consequences variable is true (this is the standard attacking second phase rule):
	if the actor is alive and the noun is alive, make the actor strike a blow against the noun.



Chapter - Concentrating

Concentrating is an action applying to nothing. Understand "concentrate" and "c" as concentrating.

A person has a number called concentration. The concentration of a person is usually 0.

Check concentrating (this is the do not concentrate when at maximum rule):
	if the concentration of the player is 3:
		take no time;
		say "You are already maximally concentrated." instead.

First carry out an actor concentrating (this is the standard concentrating improves initiative rule):
	increase the initiative of the actor by the concentration of the actor.
		
Carry out an actor concentrating (this is the standard carry out concentrating rule):	
	increase the concentration of the actor by 1;
	if the concentration of the actor is greater than 3, now the concentration of the actor is 3.
	
Last report an actor concentrating (this is the standard concentrating prose rule):
	now the global actor is the actor;
	if the concentration of the actor is 1, say "[CAP-actor] concentrate[s], and [is-are] now mildly concentrated.";
	if the concentration of the actor is 2, say "[CAP-actor] concentrate[s], and [is-are] now quite concentrated.";
	if the concentration of the actor is 3, say "[CAP-actor] concentrate[s], and [is-are] now maximally concentrated.".

An attack modifiers rule (this is the concentration attack modifier rule):
	if the concentration of the global attacker is greater than 0 begin;
		let the first dummy be 0;
		if the concentration of the global attacker is 1, now the first dummy is 2;
		if the concentration of the global attacker is 2, now the first dummy is 4;
		if the concentration of the global attacker is 3, now the first dummy is 8;
		if the numbers boolean is true, say " + ", the first dummy, " (concentration)[run paragraph on]";
		increase the to-hit modifier by the first dummy;
	end if.

A damage modifiers rule (this is the concentration damage modifier rule):
	if the concentration of the global attacker is greater than 1 begin;
		let the first dummy be 0;
		if the concentration of the global attacker is 2, now the first dummy is 2;
		if the concentration of the global attacker is 3, now the first dummy is 4;
		if the numbers boolean is true, say " + ", the first dummy, " (concentration)[run paragraph on]";
		increase the damage modifier by the first dummy;
	end if.

An aftereffects rule (this is the lose concentration when hit rule):
	if the final damage is greater than 0 and the global defender is alive, let the global defender lose concentration.

A take away until attack circumstances rule (this is the lose concentration after attacking rule):
	now the concentration of the global attacker is 0.


[Losing concentration]

The lose concentration prose rules are a rulebook.

The concentration loser is a person that varies.

To let (the defender - a person) lose concentration:
	if the concentration of the defender is 0, continue the activity;
	now the concentration of the defender is 0;
	now the concentration loser is the defender;
	consider the lose concentration prose rules.
	
Last lose concentration prose rule (this is the standard lose concentration prose rule):
	if the concentration loser is the player, say " You lose your [bold type]concentration[roman type]![run paragraph on]";
	if the concentration loser is not the player, say " [The concentration loser] loses [bold type]concentration[roman type]![run paragraph on]".




Chance to win rule (this is the CTW concentration bonus rule):
	if the concentration of the global attacker is 1, increase the chance-to-win by 2;
	if the concentration of the global attacker is 2, increase the chance-to-win by 4;
	if the concentration of the global attacker is 3, increase the chance-to-win by 8.
	

Carry out an actor going (this is the lose concentration on going rule):
	now the concentration of the actor is 0.


Chapter - Parrying


Parrying is an action applying to nothing. Understand "parry" and "p" and "pa" as parrying.

A person can be at parry or not at parry. A person is usually not at parry.

Check parrying (this is the cannot parry when not reacting rule):
	if the combat state of the player is not at-React:
		take no time;
		say "You parry, but there is no attack." instead.


Carry out an actor parrying (this is the parrying changes initiative rule):
	increase the initiative of the actor by 1.
	
Carry out an actor parrying (this is the standard carry out parrying rule):	
	now the actor is at parry.
	
Last report an actor parrying (this is the standard parry prose rule):	
	now the global actor is the actor;
	say "[CAP-actor] strike[s] up a defensive pose.".


An attack modifiers rule (this is the parry defence bonus rule):
	if the global defender is at parry:
		let n be the passive parry max of global attacker weapon;
		if the active parry max of global defender weapon is less than n, now n is the active parry max of global defender weapon;
		if the numbers boolean is true:
			if n is greater than 0, say " - ", n, " (defender parrying)[run paragraph on]";
			if n is 0 and active parry max of global defender weapon is 0:
				say " - 0 (cannot parry with [global defender weapon])[run paragraph on]";
			otherwise:
				if n is 0, say " - 0 (cannot parry against [global attacker weapon])[run paragraph on]";
		decrease the to-hit modifier by n.


A take away until attack circumstances rule (this is the no longer at parry after the attack rule):
	now the global defender is not at parry.


Best defender's action rule (this is the CTW parry bonus rule):
	let n be the passive parry max of the chosen weapon;
	let item be a random readied weapon enclosed by the chosen target;
	if the active parry max of item is less than n:
		now n is the active parry max of item;
	if the best defence is less than n:
		now the best defence is n.



Chapter - Dodging


Dodging is an action applying to nothing. Understand "dodge" and "do" as dodging.

A person can be at dodge or not at dodge. A person is usually not at dodge.

Check dodging (this is the cannot dodge when not reacting rule):
	if the combat state of the player is not at-React:
		take no time;
		say "You dodge, but there is no attack." instead.
	
Carry out an actor dodging (this is the standard carry out dodging rule):	
	now the actor is at dodge.
	
Last report an actor dodging (this is the standard dodge prose rule):
	now the global actor is the actor;
	say "[CAP-actor] get[s] ready for quick evasive maneuvers.".

An attack modifiers rule (this is the dodge defence bonus rule):
	if the global defender is at dodge begin;
		let n be the dodgability of global attacker weapon;
		if the numbers boolean is true begin;
			if n is greater than 0, say " - ", n, " (defender dodging)[run paragraph on]";
			if n is 0, say " - 0 (cannot dodge)[run paragraph on]";
		end if;
		decrease the to-hit modifier by n;
	end if.

A take away until attack circumstances rule (this is the no longer at dodge after the attack rule):
	now the global defender is not at dodge.

Best defender's action rule (this is the CTW dodge bonus rule):
	let n be the dodgability of the chosen weapon;
	if the best defence is less than n:
		now the best defence is n.





Book - Artificial Intelligence

[Our standard AI works in three stages. In the first stage, we choose a person to attack--if we were to attack. In the second stage, we choose a weapon. In the third stage, we decide whether to attack or whether to do something else--like concentrating, dodging, readying a weapon, and so on.]

[Chapter - The Tables

Table of AI Combat Person Options
Person Option					Weight
a person						a number
with 50 blank rows

Table of AI Combat Options
Option						Weight
a stored  action				a number
with 50 blank rows]

Table of AI Combat Weapon Options
Weapon	Weapon weight
a weapon	a number
with 50 blank rows



Section - Blanking out the Tables

[To blank out the AI Combat Options:
	repeat through the Table of AI Combat Options:
		blank out the whole row.

To blank out the AI Combat Person Options:
	repeat through the Table of AI Combat Person Options:
		blank out the whole row.

To blank out the AI Combat Weapon Options:
	repeat through the Table of AI Combat Weapon Options:
		blank out the whole row.]

Section - Useful variables

[Stored_row is a number that varies.

Stored_person is a person that varies.

Stored_weapon is a weapon that varies.

Stored_action is a stored action that varies.]


Section - Standard attacker AI

[The standard_attacker is a rulebook.

A standard_attacker rule:
	have the AI select a target;
	if the found-a-target boolean is true begin;
		have the AI select a weapon;
		have the AI select an action;
		try the stored_action;
	end if.]
	

Section - General AI definitions

[A person has a rulebook called the combat AI rulebook. The combat AI rulebook of a person is usually the standard_attacker rulebook.]




Chapter - First Stage - Choosing a Person

Chapter - The pressing relation

[[Pressing is mostly just a way to remember who had been attacking whom. The AI prefers continuing to attack the same person.]

Pressing relates various people to various people. The verb to press (he presses, they press, he pressed, it is pressed, he is pressing) implies the pressing relation.

[This routine takes care of the pressing relations]

To have (A - a person) start pressing (B - a person):
	repeat with X running through all persons pressed by A:
		now A does not press X;
	now A presses B.]


Section - Rulebook

[The standard AI target select rules are a rulebook.]

[The found-a-target boolean is a truth state that varies.]

[To have the AI select a target:
	blank out the whole of Table of AI Combat Person Options;
	now the found-a-target boolean is false;
	repeat with X running through all alive persons enclosed by the location:
		if the faction of the global attacker hates the faction of X:
			now the found-a-target boolean is true;
			choose a blank Row in the Table of AI Combat Person Options;
			change Person Option entry to X;
			change Weight entry to 0;
			now stored_row is the current_row;
			now stored_person is X;
			consider the standard AI target select rules;
[			say "[Person Option entry]: [Weight entry]"; [for testing]]
	if the found-a-target boolean is true:
		sort the Table of AI Combat Person Options in random order;
		sort the Table of AI Combat Person Options in reverse Weight order;
		choose row one in the Table of AI Combat Person Options;
		now the global defender is the Person Option entry.]

Section - Standard rules

[A standard AI target select rule (this is the do not prefer passive targets rule):
	choose row stored_row in Table of AI Combat Person Options;
	if stored_person is passive, decrease the Weight entry by 5.	

A standard AI target select rule (this is the prefer targets you press rule):
	choose row stored_row in Table of AI Combat Person Options;
	if the global attacker presses stored_person, increase the Weight entry by 3.

A standard AI target select rule (this is the prefer those who press you rule):
	choose row stored_row in Table of AI Combat Person Options;
	if the stored_person presses the global attacker, increase the Weight entry by 1.

A standard AI target select rule (this is the prefer the player rule):
	choose row stored_row in Table of AI Combat Person Options;
	if the stored_person is the player, increase the Weight entry by 1.]

A standard AI target select rule for a person (called target) (this is the prefer the severely wounded rule):
	if the health of the target times 2 is less than the permanent health of the target:
		increase the Weight by 2;
	if the health of the target times 4 is less than the permanent health of the target:
		increase the Weight by 5;

A standard AI target select rule for a person (called target) (this is the prefer concentrated people rule):
	increase the Weight by the concentration of the target;
	if the concentration of the target is 3:
		increase the Weight by 2;

A standard AI target select rule for a person (called target) (this is the prefer those with good weapons rule):
	let item be a random readied weapon enclosed by the target;
	increase the Weight by the damage die of the item divided by 2;

A standard AI target select rule for a person (called target) (this is the do not prefer good parriers rule):
	let item be a random readied weapon enclosed by the main actor;
	let item2 be a random readied weapon enclosed by the target;
	let n be the passive parry max of item;
	if the active parry max of item2 is less than n:
		now n is the active parry max of item2;
	if the dodgability of item is less than n:
		now n is n minus the dodgability of item;
	otherwise:
		now n is 0;
	decrease the Weight by n;

[The following rule makes the actor prefer people with low defence, unless he is concentrated, in which case he prefers people with high defence. Reason: if you managed to become concentrated, you should use that bonus against otherwise tough opponents.]

A standard AI target select rule for a person (called target) (this is the do not prefer high defence unless concentrated rule):
	let n be the defence of the target minus the melee of the main actor;
	if n is less than 0:
		now n is 0;
	let m be the concentration of main actor minus 1;
	[Negative if concentration = 0; 0 is concentration is 1; positive if concentration is 2 or 3.]
	increase the Weight by n times m;

[A standard AI target select rule for [an at-Act] person (called P) (this is the randomise the target result rule):
	repeat through the Table of AI Combat Person Options:
		increase the Weight entry by a random number between 0 and 4;]



Chapter - Second Stage - Choosing a Weapon


The standard AI weapon select rules are a weapon based rulebook producing a number.
The standard AI weapon select rulebook has a number called the Weight.

The chosen weapon is a weapon variable.

A Standard AI rule for a person (called P) (this is the select a weapon rule):
	if exactly one weapon is enclosed by P:
		now the chosen weapon is a random weapon enclosed by the global attacker;
	otherwise:
		blank out the whole of the Table of AI Combat Weapon Options;
		repeat with X running through all weapons enclosed by the P:
			let weight be the number produced by the standard AI weapon select rules for X;
			choose a blank Row in the Table of AI Combat Weapon Options;
			change the Weapon entry to X;
			change the Weapon weight entry to weight;
		sort the Table of AI Combat Weapon Options in random order;
		sort the Table of AI Combat Weapon Options in reverse Weapon weight order;
		choose row 1 in the Table of AI Combat Weapon Options;
		now the chosen weapon is the Weapon entry;

[To have the AI select a weapon:
	if exactly one weapon is enclosed by the global attacker:
		now the stored_weapon is a random weapon enclosed by the global attacker;
	otherwise:
		blank out the whole of the Table of AI Combat Weapon Options;
		repeat with X running through all weapons enclosed by the global attacker:
			choose a blank Row in the Table of AI Combat Weapon Options;
			change Weapon Option entry to X;
			change Weight entry to 0;
			now stored_row is the current_row;
			now stored_weapon is X;
			consider the standard AI weapon select rules;
[			say "[Weapon Option entry]: [Weight entry]"; [for testing]]
		sort the Table of AI Combat Weapon Options in random order;
		sort the Table of AI Combat Weapon Options in reverse Weight order;
		choose row one in the Table of AI Combat Weapon Options;
		now the stored_weapon is the Weapon Option entry. ]


Section - Standard rules

[ These rules are dependent on the W, and not whether they are being run for the attacker or the defender. It should be possible to determine who that is by checking who holds the weapon. ]

A standard AI weapon select rule for a weapon (called W) (this is the prefer lots of damage rule):
	increase the Weight by the damage die of W;

A standard AI weapon select rule for a weapon (called W) (this is the prefer low dodgability and passive parry rule):
	let n be the dodgability of the W;
	if the passive parry max of the W is greater than n:
		now n is the passive parry max of the W;
	decrease the Weight by n;

A standard AI weapon select rule for a weapon (called W) (this is the prefer good active parry rule):
	increase the Weight by the active parry max of the W divided by 2;

A standard AI weapon select rule for a weapon (called W) (this is the prefer good attack bonus rule):
	let n be the weapon attack bonus of the W times three;
	now n is (n + 1) divided by 2;
	increase the Weight by n.

[A standard AI weapon select rule (this is the prefer readied weapon rule):
	choose row stored_row in Table of AI Combat Weapon Options;
	if the Weapon Option entry is readied:
		if the combat state of the actor is at-Act:
			increase the Target weight entry by 3;
		if the combat state of the actor is at-React:
			increase the Target weight entry by 3.]

[ ??? Neither of these rules actually care who the weapon belongs to... is that the intended behaviour? Should we combine these rules together to a prefer readied weapon if the end is near rule? ]
A standard AI weapon select rule for a weapon (called W) (this is the prefer readied weapon if attacker almost dead rule):
	if four times the health of the main actor is less than the permanent health of the main actor:
		if W is readied:
			increase the Weight by 2;

A standard AI weapon select rule for a weapon (called W) (this is the prefer readied weapon if defender almost dead rule):
	if four times the health of the chosen target is less than the permanent health of the chosen target:
		if W is readied:
			increase the Weight by 2;

[A standard AI weapon select rule (this is the randomise the weapon result rule):
	choose row stored_row in Table of AI Combat Weapon Options;
	increase the Target weight entry by a random number between 0 and 2.]

A last standard AI weapon select rule (this is the return the weapon weight rule):
	rule succeeds with result Weight;


Chapter - Third Stage - Choosing an Action

[The standard AI action select rules are a rulebook.]

[To have the AI select an action:
	blank out the whole of the Table of AI Combat Options;
	consider the standard AI action select rules;
	sort the Table of AI Combat Options in random order;
	sort the Table of AI Combat Options in reverse Weight order;
	choose row one in the Table of AI Combat Options;
	now the stored_action is the Option entry. ]

Section - Standard select rules

[For every possible action, there MUST be a "first" rule adding it to the table.]

First standard AI action select rule for an at-Act person (called P) (this is the consider attacking rule):
	choose a blank Row in the Table of AI Combat Options;
	now the Option entry is the action of P attacking the chosen target;
	now the Action Weight entry is 5;

First standard AI action select rule for a person (called P) (this is the consider concentrating rule):
	choose a blank Row in the Table of AI Combat Options;
	now the Option entry is the action of P concentrating;
	now the Action Weight entry is 3;

First standard AI action select rule for an at-React person (called P) (this is the consider dodging rule):
	choose a blank Row in the Table of AI Combat Options;
	now the Option entry is the action of P dodging;
	now the Action Weight entry is 5;

First standard AI action select rule for an at-React person (called P) (this is the consider parrying rule):
	choose a blank Row in the Table of AI Combat Options;
	now the Option entry is the action of P parrying;
	now the Action Weight entry is 5;

First standard AI action select rule for a person (called P) when the chosen weapon is not readied (this is the consider readying rule):
	choose a blank Row in the Table of AI Combat Options;
	now the Option entry is the action of P readying the chosen weapon;
	now the Action Weight entry is 5;

[First standard AI action select rule (this is the consider waiting rule):
	choose a blank Row in the Table of AI Combat Options;
	change the Option entry to the action of the global attacker waiting;
	change the Target weight entry to -20.]


Section - Calculating the chance to win

The chance to win rules is a rulebook.

The chance-to-win is a number that varies. The normalised chance-to-win is a number that varies.

First standard AI action select rule (this is the calculate the chance to win rule):
	consider the chance to win rules.

First chance to win rule (this is the CTW default rule):
	now the chance-to-win is 10.

Chance to win rule (this is the CTW melee bonus rule):
	increase the chance-to-win by the melee of the main actor;

Chance to win rule (this is the CTW defence bonus rule):
	decrease the chance-to-win by the defence of the main actor;
	
[Other rules are in the appropriate sections.]	

[Now we are going to calculate what the best defensive action of the global defender is, and we will use that to calculate the chance to win.]

The best defender's action rules are a rulebook.

The best defence is a number that varies. The best defence is usually 0.
	
Chance to win rule (this is the consider best defender's action rule):
	now the best defence is 0;
	consider the best defender's action rules;
	decrease the chance-to-win by the best defence.


Last chance to win rule (this is the normalised CTW rule):
	now the normalised chance-to-win is the chance-to-win;
	if the normalised chance-to-win is greater than 10, now the normalised chance-to-win is 10;
	if the normalised chance-to-win is less than 0, now the normalised chance-to-win is 0.


Section - Standard rules

A standard AI action select rule for an at-Act person (called P) (this is the standard attack select rule):
	choose row with an Option of the action of the main actor attacking the chosen target in the Table of AI Combat Options;
	if the normalised chance-to-win is 0:
		change the Action Weight entry to -100;
	decrease the Action Weight entry by 5;
	increase the Action Weight entry by the normalised chance-to-win;

A standard AI action select rule for a person (called P) (this is the standard concentration select rule):
	choose row with an Option of the action of P concentrating in the Table of AI Combat Options;
	increase the Action Weight entry by 5;
	decrease the Action Weight entry by the chance-to-win;
	if the concentration of P is 3:
		now the Action Weight entry is -100;

A standard AI action select rule for an at-Act person (called P) (this is the concentration influences attacking rule):
	choose row with an Option of the action of the main actor attacking the chosen target in the Table of AI Combat Options;
	increase the Action Weight entry by the concentration of the chosen target;
	if the concentration of the chosen target is 3:
		increase the Action Weight entry by 2;

A standard AI action select rule for an at-React person (called P) (this is the standard parry and dodge against attack select rule):
	if the main actor's action is the attacking action:
		let the attacker's weapon be a random readied weapon enclosed by the main actor;
		let the defendant's weapon be a random readied weapon enclosed by P;
		let dodgability be the dodgability of the attacker's weapon;
		let parry rating be the passive parry max of the attacker's weapon;
		if parry rating is greater than the active parry max of the defendant's weapon:
			now parry rating is the active parry max of the defendant's weapon;
		[ Adjust the weight of dodging ]
		choose row with an Option of the action of P dodging in the Table of AI Combat Options;
		increase the Action Weight entry by dodgability;
		if parry rating is greater than dodgability:
			decrease the Action Weight entry by 100;
		[ Adjust the weight of parrying ]
		choose row with an Option of the action of P parrying in the Table of AI Combat Options;
		increase the Action Weight entry by parry rating;
		if parry rating is 0:
			decrease the Action Weight entry by 100;
		if dodgability is greater than parry rating:
			decrease the Action Weight entry by 100.


A standard AI action select rule for a person (called P) when the chosen weapon is not readied (this is the don't attack or concentrate with an unreadied weapon rule):
	if P is at-Act:
		choose row with an Option of the action of P attacking the chosen target in the Table of AI Combat Options;
		now the Action Weight entry is -1000;
	choose row with an Option of the action of P concentrating in the Table of AI Combat Options;
	now the Action Weight entry is -100;
	[ Incorporated into this is the consider readying rule. ]
	[choose row with an Option of the action of P readying the chosen weapon in the Table of AI Combat Options;
	increase the Action Weight entry by 5;]


Last standard AI action select rule (this is the randomise the action result rule):
	repeat through the Table of AI Combat Options:
		increase the Action Weight entry by a random number between 0 and 5;
[		say "[Option entry]: [Target weight entry][line break]"; [For testing]]










Book - Weapons

Chapter - The weapon kind



[A readied weapon is one that is not just carried by the actor, but actually in use.]

[The damage die is the die size used to calculate damage. Base damage dealt by the weapon is 1d(damage die) + weapon damage bonus. So a standard weapon deals 1d6 damage; a weapon with a damage die of 0 and a weapon damage bonus of 5 always deals 5 damage, and so on. Negative damage die is counted as 0, but negative weapon damage bonus is possible.]
A weapon has a number called the damage die. The damage die of a weapon is usually 6.
A weapon has a number called the weapon damage bonus. The weapon damage bonus of a weapon is usually 0.

[The dodgability of a weapon is the bonus a defender gets against it when dodging.]
A weapon has a number called the dodgability. The dodgability of a weapon is usually 2.

[The passive parry max is the maximum bonus a defender can get when parrying AGAINST this weapon.]
A weapon has a number called the passive parry max. The passive parry max is usually 2.

[The active parry max is the maximum bonus a defender can get when parrying WITH this weapon.]
A weapon has a number called the active parry max. The active parry max is usually 2.

A weapon has a number called the weapon attack bonus. The weapon attack bonus of a weapon is usually 0.


Section - Weapon attack bonus

An attack modifiers rule (this is the attack bonus from weapon rule):
	let item be a random readied weapon enclosed by the global attacker;
	let n be the weapon attack bonus of item;
	if the numbers boolean is true begin;
		if n is greater than 0, say " + ", n, " ([item] bonus)[run paragraph on]";
		if n is less than 0, say " - ", 0 minus n, " ([item] penalty)[run paragraph on]";
	end if;
	increase the to-hit modifier by n.

Chance to win rule (this is the CTW attack bonus from weapon rule):
	increase the chance-to-win by the weapon attack bonus of the chosen weapon.


Chapter - The ready action

Section - The action itself

Readying is an action applying to one visible thing.

Understand "ready [thing]" as readying. Understand "wield [thing]" and "use [weapon]" as readying.

Does the player mean readying a readied weapon: it is unlikely.

Check readying (this is the cannot ready what is already readied rule):
	if the noun is readied and the noun is enclosed by the player:
		take no time;
		say "You are already wielding [the noun]." instead.

Check readying (this is the cannot ready what is not a weapon rule):
	if the noun is not a weapon:
		take no time;
		say "You can only ready weapons." instead.

First carry out an actor readying (this is the implicit taking when readying rule):
	if the actor does not enclose the noun:
		try the actor taking the noun.

Carry out an actor readying (this is the carry out readying when enclosing rule):
	if the actor encloses the noun:
		now the noun is readied.

Last carry out an actor readying (this is the unready all other weapons rule):
	if the noun is readied:
		repeat with item running through things enclosed by the actor:
			if the item is not the noun and the item is readied:
				now the item is not readied.

Report an actor readying (this is the standard report readying rule):
	now the global actor is the actor;
	if the noun is readied:
		say "[CAP-actor] read[ies] [the noun].";
	otherwise:
		if the actor encloses the noun:
			say "[CAP-actor] fool[if the global actor is the player or the global actor is plural-named][otherwise]s[end if] around with [the noun], but fail[if the global actor is the player or the global actor is plural-named][otherwise]s[end if] to ready it.";
		otherwise:
			say "[CAP-actor] attempt[if the global actor is the player or the global actor is plural-named][otherwise]s[end if] to ready [the noun], but cannot get hold of it.".


After printing the name of a readied weapon while taking inventory (this is the readied inventory listing rule):
	say " (readied)".

After dropping a readied weapon (this is the unready on dropping rule):
	now the noun is not readied; continue the action.

After putting on a readied weapon (this is the unready on putting on rule):
	now the noun is not readied; continue the action.

After inserting into a readied weapon (this is the unready on inserting rule):
	now the noun is not readied; continue the action.


Section - Natural weapons

A natural weapon is a kind of weapon.
A natural weapon is part of every person.
A natural weapon is usually privately-named.

Instead of examining a natural weapon (this is the standard description of a natural weapon rule):
	say "Clenched fists, kicking feet--that kind of stuff.".

The damage die of a natural weapon is usually 3. The dodgability of a natural weapon is usually 2. The passive parry max of a natural weapon is usually 2. The active parry max of a natural weapon is usually 0.

Does the player mean readying a natural weapon:
	it is very unlikely.

Section - Making sure a weapon is always readied

[First every turn rule (this is the ready natural weapons if no other weapon readied rule):
	repeat with X running through all alive persons enclosed by the location:
		if X encloses no readied weapon:
			let item be a random natural weapon part of X;
			now item is readied.]

To ready natural weapons: [run every combat round, just to be sure]
	repeat with X running through all alive persons enclosed by the location:
		if X encloses no readied weapon:
			let item be a random natural weapon part of X;
			now item is readied.	

When play begins (this is the ready weapons for everyone rule):
	repeat with X running through all alive persons:
		if X encloses no readied weapon:
			if X carries at least one weapon:
				let item be a random weapon carried by X;
				now item is readied;
			otherwise:
				let item be a random natural weapon part of X;
				now item is readied.




Volume - Plug-ins


Chapter - Reloadable Weapons (Standard Plug-in)

Section - Reloading

A weapon has a number called the maximum shots. The maximum shots of a weapon is usually 0.
A weapon has a number called the current shots. The current shots of a weapon is usually 0.
A weapon has a number called the maximum load time. The maximum load time of a weapon is usually 0. 
A weapon has a number called the current load time. The current load time of a weapon is usually 0.

Definition: a weapon is unloaded if its current shots is 0 and its maximum shots is greater than 0.
Definition: a weapon is waiting to be reloaded if its current shots is 0 and its maximum shots is greater than 0 and its maximum load time is greater than 0.

A weapon has a text called the shots text. The shots text of a weapon is usually "shots".
A weapon has a text called the reload text. The reload text of a weapon is usually "reload".
A weapon has a text called the reload stem text. The reload stem text of a weapon is usually "reload".
A weapon has a text called the out of ammo text. The out of ammo text of a weapon is usually "You pull the trigger, but nothing happens--you're out of ammo!".

[Maximum shots: number of rounds the weapon can be used when fully loaded. Current shots: number of shots still loaded. Maximum load time: number of rounds it takes to load the weapon. Current load time: number of rounds it still takes to load the weapon.]

[Set maximum shots to 0 for any weapon that shouldn't use these statistics. Set maximum load time to -1 in case a weapon cannot be reloaded. NEVER set maximum load time to 0 for a weapon with maximum shots not 0.]

[The basic system does NOT deal with ammo. Everyone is assumed to have infinite ammunition.]

After printing the name of a weapon (called item) when taking inventory (this is the show ammo in inventory rule):
	if the maximum shots of item is not 0:
		if the current shots of item is not 0:
			say " ([current shots of item] of [maximum shots of item] [shots text of item] left)";
		otherwise:
			if the maximum load time of item is not -1:
				say " (no [shots text of item] left; [current load time of item] round[if current load time of item is not 1]s[otherwise] to [reload text of item])";
			otherwise:
				say " (no [shots text of item] left; cannot be [reload stem text of item]ed)".


An aftereffects rule (this is the decrease ammo rule):
	let item be a random readied weapon enclosed by the global attacker;
	if the maximum shots of item is greater than 0 begin;
		decrease the current shots of item by 1;
	end if.

Check attacking (this is the cannot attack when out of ammo rule):
	let item be a random readied weapon enclosed by the player;
	if the maximum shots of item is greater than 0:
		if the current shots of item is not greater than 0:
			say "[out of ammo text of item][paragraph break]" instead.

Reloading is an action applying to one carried thing.

Understand "reload [held weapon]" as reloading.

Does the player mean reloading an unloaded readied weapon enclosed by the player: it is very likely.
Does the player mean reloading an unloaded weapon enclosed by the player: it is likely.

Check reloading (this is the cannot reload weapons that use no ammo rule):
	if the maximum shots of the noun is 0:
		take no time;
		say "[The noun] does not use ammunition." instead;
	
Check reloading (this is the cannot reload unreloadable weapons rule):	
	if the maximum load time of the noun is -1:
		take no time;
		say "[The noun] cannot be [reload stem text of the noun]ed." instead;
	
Check reloading (this is the cannot reload fully loaded weapons rule):	
	if the current shots of the noun is the maximum shots of the noun:
		take no time;
		say "[The noun] is already loaded." instead.

Carry out an actor reloading (this is the ready upon reloading rule):
	if the noun is not readied:
		silently try readying the noun.

Carry out an actor reloading (this is the zero current ammo on reloading rule):
	now current shots of the noun is 0.
	
Carry out an actor reloading (this is the standard carry out reloading rule):
	decrease the current load time of the noun by 1;
	if the current load time of the noun is less than 1:
		now the current shots of the noun is the maximum shots of the noun;
		now the current load time of the noun is the maximum load time of the noun.
	
Report an actor reloading (this is the standard report reloading rule):
	now the global actor is the actor;
	if the current load time of the noun is the maximum load time of the noun:
		say "[CAP-actor] [if the maximum load time of the noun is 1][reload text of the noun][s][otherwise]finish[es] [reload stem text of the noun]ing[end if] [the noun].";
	otherwise:
		say "[CAP-actor] [if the current load time of the noun plus 1 is the maximum load time of the noun]start[s][otherwise]continue[s][end if] [reload stem text of the noun]ing [the noun].".


	
	

Section - Reloading and choosing a weapon

[Weapons with high load times and limited ammo should not be given a penalty if they are already readied and full; some penalty if they are not readied; and a larger penalty if they are not readied and out of ammo.]

Standard AI weapon select rule for a weapon (called W) (this is the do not choose an empty weapon that cannot be reloaded rule):
	if the W is unloaded:
		if the maximum load time of the W is -1:
			decrease the Weight by 1000;

Standard AI weapon select rule for a weapon (called W) (this is the do not prefer weapons that need to be reloaded rule):
	if W is not readied or the current shots of W is 0:
		if the maximum shots of the W is not 0:
			if the maximum load time of the W is greater than 0:
				let m be the maximum shots of the W;
				let n be the maximum load time of the W;
				let x be m times 10;
				let y be m + n;
				now x is x divided by y; [Now x is roughly 10 times the fraction of time spent shooting in a shoot-reload cycle.]
				now x is 10 minus x; [Now x is roughly 10 times the fraction of time NOT spent shooting in a shoot-reload cycle.]
				if the current shots of the W is not 0: [This means that the weapon is (somewhat) loaded, but not ready. Using such a weapon can be done without ever reloading it: we ready it, shoot until empty, then ready a new weapon. This is AS IF we had to reload for two rounds in order to shoot as many shots as the weapon currently has. We now calculate this, and if it's better than the previous calculation, we substitute it for it.]
					now n is 2;
					now m is the current shots of the W;
					let z be m times 10;
					let y be m + n;
					now z is z divided by y;
					now z is 10 minus z;
					if z is less than x, now x is z;
				decrease the Weight by x;
	
[Example: a weapon that takes 1 turn to reload and gives you 1 shot gets a -5 penalty. A weapon that takes 3 turns to reload and gives you 1 shot gets a -8 penalty. A weapon that takes 1 turn to reload and gives you 5 shots gets a -2 penalty. ]

[Weapons with 0 ammo and a maximum load time of -1 should NOT be chosen.]


[ We will only load an unloaded weapon. ]

First standard AI action select rule for a person (called P) when the chosen weapon is waiting to be reloaded (this is the consider reloading rule):
	choose a blank Row in the Table of AI Combat Options;
	change the Option entry to the action of P reloading the chosen weapon;
	change the Action Weight entry to 5.

[Standard AI action select rule (this is the do not reload weapons that do not use ammo rule):
	choose row with an Option of the action of the global attacker reloading the stored_weapon in the Table of AI Combat Options;
	if the maximum shots of the stored_weapon is 0:
		decrease the Target weight entry by 1000.]
				
[Standard AI action select rule for a person (called P) when the chosen weapon is unloaded (this is the do not reload weapons that are not empty rule):
	choose row with an Option of the action of the global attacker reloading the stored_weapon in the Table of AI Combat Options;
	if the the current shots of the stored_weapon is greater than 0:
		decrease the Target weight entry by 100.]

[Standard AI action select rule for a person (called P) when the chosen weapon is unloaded (this is the do not reload weapons that cannot be reloaded rule):
	choose row with an Option of the action of the P reloading the chosen weapon in the Table of AI Combat Options;
	if the maximum load time of the chosen weapon is -1:
		decrease the Action Weight entry by 1000;]
	
[Standard AI action select rule for an at-Act person (called P) when the chosen weapon is unloaded (this is the do not attack with unloaded weapon rule):
	choose row with an Option of the action of P attacking the chosen target in the Table of AI Combat Options;
	decrease the Action Weight entry by 1000.
		
Standard AI action select rule for a person (called P) when the chosen weapon is unloaded (this is the do not concentrate with unloaded weapon rule):		
	choose row with an Option of the action of P concentrating in the Table of AI Combat Options;
	decrease the Action Weight entry by 100.]

[These two become the following, to match the don't attack or concentrate with an unreadied weapon rule. ]
A standard AI action select rule for a person (called P) when the chosen weapon is unloaded (this is the don't attack or concentrate with an unloaded weapon rule):
	if P is at-Act:
		choose row with an Option of the action of P attacking the chosen target in the Table of AI Combat Options;
		now the Action Weight entry is -1000;
	choose row with an Option of the action of P concentrating in the Table of AI Combat Options;
	now the Action Weight entry is -100;

[ Combined with the first rule ]
[Standard AI action select rule for a person (called P) when the chosen weapon is waiting to be reloaded (this is the reload when you have an unloaded weapon rule):		
	choose row with an Option of the action of P reloading the chosen weapon in the Table of AI Combat Options;
	increase the Action Weight entry by 5.]


Chapter - Tension (Standard Plug-in)

[Tension is a standard plug-in, since I believe almost any game will benefit from it. Tension is a kind of "drama manager" for combat: it makes sure that long periods in which no apparent progress is made--that is, in which no damage is done--are not experienced as boring, but rather as increasing the tension. The way it works is that every turn when no hit is scored, the tension (a number that varies) is increased by one. High tension gives everyone bonuses on the attack roll, thus increasing the likelihood that something will happen, and on the damage roll, thus increasing the stakes.

Tension also works as a check and balance on the combat system: if you have made it too hard for people to hit each other, tension will greatly alleviate this problem.]

The tension is a number that varies. The tension is usually 0.

Every turn (this is the standard increase or reset the tension rule):
	if not hate is present:
		now the tension is 0;
	otherwise:
		increase the tension by 1;
	if the tension is greater than 20, now the tension is 20.
	
An attack modifiers rule (this is the standard tension attack modifier rule):
	let the first dummy be 0;
	now the first dummy is the tension divided by 2;
	if the first dummy is not 0:
		if the numbers boolean is true, say " + ", the first dummy, " (tension)[run paragraph on]";
		increase the to-hit modifier by the first dummy.
		
A damage modifiers rule (this is the standard tension damage modifier rule):
	let the first dummy be 0;
	now the first dummy is the tension divided by 3;
	if the first dummy is not 0:
		if the numbers boolean is true, say " + ", the first dummy, " (tension)[run paragraph on]";
		increase the damage modifier by the first dummy.

An aftereffects rule (this is the standard reduce tension after hit rule):		
	if the final damage is greater than 0:
		now the tension is the tension minus 4;
		now the tension is the tension times 8;
		now the tension is the tension divided by 10;
		if the tension is less than 0, now the tension is 0.

	
[A hit must reduce the tension, but not necessarily completely down to 0. We want low tensions to be completely removed by a hit, but larger tension to be removed only partly. The standard rule leads to the following table:

0 -> 0
1 -> 0
2 -> 0
3 -> 0
4 -> 0
5 -> 0
6 -> 1
7 -> 2
8 -> 2
9 -> 3
10 -> 4
11 -> 4
12 -> 5
13 -> 6
14 -> 7
15 -> 7
16 -> 8
17 -> 9
18 -> 9
19 -> 10
20 -> 11

So if the current tension is 10, my attack will have an attack bonus of +5 and a damage bonus of +3. If I hit, the tension will drop to 4, will then be immediately raised to 5 by the every turn rule, and my opponent's attack the next round will be made at a +2 to attack and +1 to damage.

You can see that if the current tension is 10 and I am maximally concentrated, my attack is made at a gigantic +13 attack bonus, and will deliver a +7 damage bonus. ]
		
Chance to win rule (this is the CTW tension bonus rule):
	increase the chance-to-win by the tension divided by 2.

A standard AI action select rule for an at-Act person (called P) (this is the tension influences attacking rule):
	choose row with an Option of the action of P attacking the chosen target in the Table of AI Combat Options;
	increase the Action Weight entry by the tension divided by 4.
	

Inform ATTACK ends here.
