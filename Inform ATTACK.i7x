Version 4/120603 of Inform ATTACK by Victor Gijsbers begins here.

"Inform ATTACK: the Inform Advanced Turn-based TActical Combat Kit"

"GPL 3 licenced"



Volume - Introduction

Include Inform ATTACK Core by Victor Gijsbers.
Include Plurality by Emily Short.

Section - Saying combat numbers

[ See manual section 2.1.2 ]

[ This variable determines whether we see numerical output. ]
The numbers boolean is a truth state variable. The numbers boolean is true.

Checking the numbers boolean is an action out of world. Understand "numbers" as checking the numbers boolean.
Carry out checking the numbers boolean (this is the standard checking the numbers boolean rule):
	say "Combat-related numbers will be [if the numbers boolean is true]displayed[otherwise]hidden[end if].".

Switching the numbers off is an action out of world. Understand "numbers off" as switching the numbers off.
Carry out switching the numbers off (this is the standard switching the numbers off rule):
	now the numbers boolean is false;
	say "You will no longer see combat-related numbers.".

Switching the numbers on is an action out of world. Understand "numbers on" as switching the numbers on.
Carry out switching the numbers on (this is the standard switching the numbers on rule):
	now the numbers boolean is true;
	say "You will now see combat-related numbers.".



Volume - The Main System

[The Main System covers the basics of combat, and creates rulebooks for all other systems to fit into.]



Book - Dressing up the Person Class

Chapter - Looting

[To make looting possible.]
The can't take people's possessions rule is not listed in any rulebook.

Check an actor taking (this is the can't take living people's possessions rule):
	let the local ceiling be the common ancestor of the actor with the noun;
	let H be the not-counting-parts holder of the noun;
	while H is not nothing and H is not the local ceiling:
		if H is an alive person, stop the action with library message taking action
			number 6 for H;
		let H be the not-counting-parts holder of H;

After examining a dead person (this is the give list of possession on dead person rule):
	if the number of things carried by the noun is at least one:
		say "On the [if the noun is plural-named]bodies[otherwise]body[end if] of [the noun] you also see [list of things carried by the noun with indefinite articles].".

Chapter - Health

A person has a number called permanent health. [The maximum you can regain with healing.]

When play begins (this is the set permanent health to initial health rule):
	repeat with the patient running through people:
		now the permanent health of the patient is the health of the patient;

[We set the permanent health of each individual to the health it has at the beginning of the game. If we wish any character to start the game wounded or super-healthy, we will have to manually override this process.]

To restore the health of (patient - a person):
	now the health of the patient is the permanent health of the patient. 

To fully heal (patient - a person):
	if the permanent health of the patient is greater than the health of the patient:
		restore the health of the patient.

[The healed amount is a number that varies. The healed amount is usually 0.]

To heal (patient - a person) for (health - a number) health:
	let the health dummy be the permanent health of the patient minus the health of the patient;
	if health is less than the health dummy, now the health dummy is health;
	if the health dummy is less than 0, now the health dummy is 0;
	increase the health of the patient by the health dummy;
	[now the healed amount is the health dummy.] [For storage.]

Chapter - Basic Combat Stats

[Melee is a measure of fighting prowess. Higher melee means higher chance to hit.]
A person has a number called melee. The melee of a person is usually 0. 

[Defence is a measure of fighting prowess. Higher defence means less chance to get hit.]
A person has a number called defence. The defence of a person is usually 7.



Book - Weapons

Chapter - The weapon kind

A weapon is a kind of thing.

[ A readied weapon is one that is not just carried by the actor, but actually in use. ]
A weapon is either readied or not readied. A weapon is usually not readied.

After printing the name of a readied weapon while taking inventory (this is the readied inventory listing rule):
	say " (readied)".

[ The damage die is the die size used to calculate damage. Base damage dealt by the weapon is 1d(damage die) + weapon damage bonus. So a standard weapon deals 1d6 damage; a weapon with a damage die of 0 and a weapon damage bonus of 5 always deals 5 damage, and so on. Negative damage die is counted as 0, but negative weapon damage bonus is possible. ]
A weapon has a number called the damage die. The damage die of a weapon is usually 6.
A weapon has a number called the weapon damage bonus. The weapon damage bonus of a weapon is usually 0.

[The dodgability of a weapon is the bonus a defender gets against it when dodging.]
A weapon has a number called the dodgability. The dodgability of a weapon is usually 2.

[The passive parry max is the maximum bonus a defender can get when parrying AGAINST this weapon.]
A weapon has a number called the passive parry max. The passive parry max is usually 2.

[The active parry max is the maximum bonus a defender can get when parrying WITH this weapon.]
A weapon has a number called the active parry max. The active parry max is usually 2.

Section - Weapon attack bonus

A weapon has a number called the weapon attack bonus. The weapon attack bonus of a weapon is usually 0.

A calculating the attack roll rule (this is the attack bonus from weapon rule):
	let n be the weapon attack bonus of the global attacker weapon;
	if the numbers boolean is true:
		if n is greater than 0:
			say " + ", n, " ([the global attacker weapon] bonus)[run paragraph on]";
		if n is less than 0:
			say " - ", 0 minus n, " ([the global attacker weapon] penalty)[run paragraph on]";
	increase the roll by n.

Chance to win rule (this is the CTW attack bonus from weapon rule):
	increase the chance-to-win by the weapon attack bonus of the chosen weapon.

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

To ready natural weapons (deprecated):
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

A starting the combat round rule (this is the ready natural weapons rule):
	repeat with X running through all alive persons enclosed by the location:
		if X encloses no readied weapon:
			let item be a random natural weapon part of X;
			now item is readied;

Section - Unreadying weapons

After dropping a readied weapon (this is the unready on dropping rule):
	now the noun is not readied;
	continue the action.

After putting on a readied weapon (this is the unready on putting on rule):
	now the noun is not readied;
	continue the action.

After inserting into a readied weapon (this is the unready on inserting rule):
	now the noun is not readied;
	continue the action.



Book - Combat Round

[A person has a person called the provoker.
A person has an action-name called the provocation.]

Chapter - Setting up the Combat Order

Section - Initiative

An aftereffects rule (this is the modify initiative based on combat results rule):
	if the final damage is greater than 0:
		decrease the initiative of the global defender by 2;
	otherwise:
		decrease the initiative of the global attacker by 2;



Book - Striking a Blow

Chapter - Striking a blow

The global attacker is a person variable.
The global defender is a person variable.
The global attacker weapon is a weapon variable.
The global defender weapon is a weapon variable.

The attack roll is a number variable.
The final damage is a number variable.

[ The old system has been converted into an activity. Instead of the old entry point system we now have:
	1: does attacking begin?
		add before striking a blow rules 
	2: preliminary results of attacking
		add last before striking a blow rules
	3-6: basic attack roll, apply the attack modifiers, calculate results of the attack roll, show results of the attack roll
		these have been combined into the calculating the attack roll rules
	7: did the attack hit?
		unchanged
	8: immediate results of hitting
		unchanged
	9-12: rolling the die for damage, modifying the damage, calculating the final damage, showing the damage
		these have been combined into the dealing damage rules
	13: pre-prose-generation effects
		unchanged
	14: reporting the results of the blow
		unchanged
	15: aftereffects
		unchanged
	16: remove temporary circumstances
		renamed to the remove temporary circumstances rules but otherwise unchanged
	17: final report
		unchanged
]

Striking a blow something is an activity on a stored action.
The striking a blow activity has a truth state called the blow proceeded.

[ These rules are used to reset anything after an attack is made, regardless of what happens. ]
The remove temporary circumstances rules is a rulebook.

[ Set up the essential blow striking variables ]
First before striking a blow [for] a stored action (called A) (this is the reset the striking a blow variables rule):
	now the global attacker is the actor part of A;
	now the global defender is the noun part of A;
	now the global attacker weapon is a random readied weapon enclosed by the global attacker;
	now the global defender weapon is a random readied weapon enclosed by the global defender;
	have the global attacker start pressing the global defender;
	now the final damage is 0;

Last before striking a blow (this is the blow was not averted rule):
	now blow proceeded is true.

For striking a blow when the blow proceeded is false (this is the stop the attack if it was averted rule):
	consider the remove temporary circumstances rules;
	rule fails;

First after striking a blow when the blow proceeded is false (this is the no aftereffects if the attack was averted rule):
	rule fails;



Section - Calculating the attack roll

The calculating the attack roll rules are a rulebook producing a number.
The calculating the attack roll rulebook have a number called the roll.

Rule for striking a blow (this is the consider the calculating the attack roll rules rule):
	now the attack roll is the number produced by the calculating the attack roll rules;
	continue the activity.

First calculating the attack roll rule (this is the standard attack roll rule):
	now the roll is a random number between 1 and 10;
	if the numbers boolean is true:
		say "[italic type]Rolling ", the roll, "[run paragraph on]".

A calculating the attack roll rule (this is the melee attack bonus rule):
	let the attacker's melee be the melee of the global attacker;
	if the numbers boolean is true and the attacker's melee is not 0:
		if the the attacker's melee is greater than 0:
			say " + ", the attacker's melee, " (inherent bonus)[run paragraph on]";
		otherwise:
			say " - ", 0 minus the attacker's melee, " (inherent penalty)[run paragraph on]";
	increase the roll by the attacker's melee;

Last calculating the attack roll rule (this is the standard show results of the attack roll rule):
	if the numbers boolean is true:
		say " = ", the roll, ", [run paragraph on]";

Last calculating the attack roll rule (this is the standard calculate results of the attack roll rule):
	rule succeeds with result the roll;



Section - Whether the attack hits & the immediate results of hitting

The whether the attack hit rules is a rulebook.

Rule for striking a blow (this is the abide by the whether the attack rules rule):
	abide by the whether the attack hit rules;
	continue the activity;

Rule for whether the attack hit (this is the standard whether the attack hit rule):
	if the attack roll is greater than the defence of the global defender:
		if the numbers boolean is true:
			say "[the global attacker] beat[s] [possessive of global defender] defence rating of ", the defence of the global defender, ".";
		continue the activity;
	otherwise:
		if the numbers boolean is true:
			say "[the global attacker] do[es] not overcome [possessive of global defender] defence rating of ", the defence of the global defender, "[roman type].";
		rule fails;

The immediate results of hitting rules is a rulebook.

Rule for striking a blow (this is the abide by the immediate results of hitting rules rule):
	abide by the immediate results of hitting rules;
	continue the activity;



Section - Dealing damage

The dealing damage rules are a rulebook producing a number.
The dealing damage rulebook have a number called the damage.

Rule for striking a blow (this is the consider the dealing damage rules rule):
	now the final damage is the number produced by the dealing damage rules;
	continue the activity.

First dealing damage rule (this is the standard damage roll rule):
	unless damage die of the global attacker weapon is less than 1:
		now the damage is a random number between 1 and the damage die of the global attacker weapon;
	increase the damage by weapon damage bonus of the global attacker weapon; [1d(damage die) + WDB]
	if the numbers boolean is true:
		say "[The global attacker] deal[s] ", the damage, "[run paragraph on]".

Last dealing damage rule (this is the can't deal negative damage rule):
	if the damage is less than 0:
		now the damage is 0;

Last dealing damage rule (this is the standard show the damage dealt rule):
	if the numbers boolean is true:
		say " = [bold type]", the damage, " damage[roman type][italic type], ";
		[no damage]
		if the the damage is less than 1:
			say "allowing [the global defender] to escape unscathed.[run paragraph on]";
		otherwise:
			[non-fatal]
			if the the damage is less than the health of the global defender:
				say "wounding [the global defender] to ", health of the global defender minus the damage, " health.[run paragraph on]" ;
			[fatal]
			otherwise:
				say "killing [the name of the global defender].[run paragraph on]";
		say "[roman type][paragraph break]";

Last dealing damage rule (this is the return the damage dealt rule):
	rule succeeds with result the damage;



Section - Aftereffects before flavour text

The aftereffects before flavour text rules is a rulebook.

After striking a blow (this is the consider the aftereffects before flavour text rules rule):
	consider the aftereffects before flavour text rules;

Aftereffects before flavour text (this is the subtract damage from health rule):
	decrease the health of the global defender by the final damage.



Section - Flavour text rules

The print flavour text rules is a rulebook.

After striking a blow (this is the consider the print flavour text rules rule):
	consider the print flavour text rules;

The intervening flavour text are a rulebook. [Use this to intervene in the normal procedure.]
The flavour are a rulebook. [In non-fatal cases]
The fatal player flavour are a rulebook. [When the player is killed.]
The fatal flavour are a rulebook. [When someone else is killed.]

A print flavour text rule (this is the flavour text structure rule):
	abide by the intervening flavour text rules;
	if the global defender is alive:
		consider the flavour rulebook;
	otherwise:
		if the global defender is the player:
			consider the fatal player flavour rulebook;
		otherwise:
			consider the fatal flavour rulebook.

Last flavour rule (this is the basic flavour rule):
	if the final damage is greater than 0:
		say "[The global attacker] hit[s] [the global defender].[run paragraph on]";
	otherwise:
		say "[The global attacker] miss[es] [the global defender].[run paragraph on]";
	continue the action.

Last fatal player flavour rule (this is the basic fatal player flavour rule):
	say "You are killed by [the name of the global attacker].".

Last fatal flavour rule (this is the basic fatal flavour rule):
	say "[The global attacker] kill[s] [the name of the global defender].".



Section - Aftereffects

The aftereffects rules is a rulebook.

After striking a blow (this is the consider the aftereffects rules rule):
	if the player is alive:
		consider the aftereffects rules;

An aftereffects rule (this is the unready weapons of dead person rule):
	if the global defender is dead:
		now all readied weapons enclosed by the global defender are not readied;

After striking a blow (this is the consider the remove temporary circumstances rules rule):
	consider the remove temporary circumstances rules;



Section - Final blow report

The final blow report rules is a rulebook.

After striking a blow (this is the consider the final blow report rules rule):
	consider the final blow report rules;

Last final blow report rule (this is the end reporting blow with paragraph break rule):
	say "[paragraph break]".



Book - Standard Combat Actions

Chapter - Readying

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
	if the noun is readied:
		say "[The actor] read[ies] [the noun].";
	otherwise:
		if the actor encloses the noun:
			say "[The actor] fool[s] around with [the noun], but fail[s] to ready it.";
		otherwise:
			say "[The actor] attempt[s] to ready [the noun], but cannot get a hold on it.".



Chapter - Attacking

The block attacking rule is not listed in any rulebook.

Understand "a [thing]" as attacking.

Does the player mean attacking a dead person:
	it is unlikely.
Does the player mean attacking a person:
	if the player opposes the noun:
		it is very likely.

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
	if the player does not oppose the noun:
		take no time;
		say "[The noun] is not your enemy." instead.

A check attacking rule (this is the cannot attack as reaction rule):
	if the combat state of the player is at-React:
		take no time;
		say "Attacking is an action, not a reaction." instead.

Carry out an actor attacking when the actor is at-Act and running delayed actions is false (this is the standard active attacking first phase rule):
	now the global attacker is the actor;
	now the global attacker weapon is a random readied weapon enclosed by the global attacker;
	consider the attack move flavour rulebook;
	choose a blank row in the Table of Stored Combat actions;
	now the Combat Speed entry is 10;
	now the Combat Action entry is the action of the actor attacking the noun;
	now the combat state of the noun is at-React;
	[now the provoker of the noun is the actor;
	now the provocation of the noun is the attacking action.]

Carry out an actor attacking when running delayed actions is true (this is the standard attacking second phase rule):
	if the actor is alive and the noun is alive:
		carry out the striking a blow activity with the current action;

The attack move flavour are a rulebook. [When someone attacks, before the other person reacts.]

Last attack move flavour rule (this is the basic attack move flavour rule):
	if the actor is not the player:
		say "[The actor] lung[es] towards [the noun].[paragraph break]".



Chapter - Concentrating

Concentrating is an action applying to nothing. Understand "concentrate" and "c" and "co" as concentrating.

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
	let C be the concentration of the actor;
	say "[The actor] concentrate[s], and [is-are]";
	if C is 1:
		say " now mildly concentrated.";
	if C is 2:
		say " now quite concentrated.";
	if C is 3:
		say " now maximally concentrated.";

A calculating the attack roll rule (this is the concentration attack modifier rule):
	let C be the concentration of the global attacker;
	if C is greater than 0:
		let the concentration bonus be 2;
		if C is 2:
			now the concentration bonus is 4;
		if C is 3:
			now the concentration bonus is 8;
		if the numbers boolean is true:
			say " + ", the concentration bonus, " (concentration)[run paragraph on]";
		increase the roll by the concentration bonus;

Rule for dealing damage (this is the concentration damage modifier rule):
	let C be the concentration of the global attacker;
	if C > 1:
		let the bonus be 2;
		if the concentration of the global attacker is 3:
			now the bonus is 4;
		if the numbers boolean is true:
			say " + ", the bonus, " (concentration)[run paragraph on]";
		increase the damage by the bonus;

An aftereffects rule (this is the lose concentration when hit rule):
	if the final damage is greater than 0 and the global defender is alive:
		let the global defender lose concentration.

A remove temporary circumstances rule (this is the lose concentration after attacking rule):
	now the concentration of the global attacker is 0.

[ Losing concentration ]

To let (the defender - a person) lose concentration:
	if the concentration of the defender > 0:
		now the concentration of the defender is 0;
		consider the lose concentration prose rules for the defender;

The lose concentration prose rules are a person based rulebook.

Last lose concentration prose rule for a person (called P) (this is the standard lose concentration prose rule):
	say " [The P] lose[s] [bold type]concentration[roman type]![run paragraph on]";

Chance to win rule (this is the CTW concentration bonus rule):
	let C be the concentration of the global attacker;
	if C is 1:
		increase the chance-to-win by 2;
	if C is 2:
		increase the chance-to-win by 4;
	if C is 3:
		increase the chance-to-win by 8;
	
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
	say "[The actor] strike[s] up a defensive pose.".

A calculating the attack roll rule (this is the parry defence bonus rule):
	if the global defender is at parry:
		let n be the passive parry max of global attacker weapon;
		if the active parry max of global defender weapon is less than n:
			now n is the active parry max of global defender weapon;
		if the numbers boolean is true:
			if n is greater than 0:
				say " - ", n, " (defender parrying)[run paragraph on]";
			if n is 0 and active parry max of global defender weapon is 0:
				say " - 0 (cannot parry with [global defender weapon])[run paragraph on]";
			otherwise:
				if n is 0, say " - 0 (cannot parry against [global attacker weapon])[run paragraph on]";
		decrease the roll by n.

A remove temporary circumstances rule (this is the no longer at parry after the attack rule):
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
	say "[The actor] get[s] ready for quick evasive maneuvers.".

A calculating the attack roll rule (this is the dodge defence bonus rule):
	if the global defender is at dodge:
		let n be the dodgability of global attacker weapon;
		if the numbers boolean is true:
			if n is greater than 0:
				say " - ", n, " (defender dodging)[run paragraph on]";
			if n is 0:
				say " - 0 (cannot dodge)[run paragraph on]";
		decrease the roll by n;

A remove temporary circumstances rule (this is the no longer at dodge after the attack rule):
	now the global defender is not at dodge.

Best defender's action rule (this is the CTW dodge bonus rule):
	let n be the dodgability of the chosen weapon;
	if the best defence is less than n:
		now the best defence is n.



Book - Artificial Intelligence

[ Our standard AI works in three stages.
	First, we choose a person to attack--if we were to attack.
	In the second stage, we choose a weapon.
	In the third stage, we decide whether to attack or whether to do something else--like concentrating, dodging, readying a weapon, and so on.
	
These choices are made by a series of rulebooks which alter the weighting of each potential target/weapon/action.

Inform ATTACK Core has the base rules - we now add combat specific ones. ]

Section - Target selection rules

A standard AI target selection rule for a person (called target) (this is the prefer the severely wounded rule):
	if the health of the target times 2 is less than the permanent health of the target:
		increase the Weight by 2;
	if the health of the target times 4 is less than the permanent health of the target:
		increase the Weight by 5;

A standard AI target selection rule for a person (called target) (this is the prefer concentrated people rule):
	increase the Weight by the concentration of the target;
	if the concentration of the target is 3:
		increase the Weight by 2;

A standard AI target selection rule for a person (called target) (this is the prefer those with good weapons rule):
	let item be a random readied weapon enclosed by the target;
	increase the Weight by the damage die of the item divided by 2;

A standard AI target selection rule for a person (called target) (this is the do not prefer good parriers rule):
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

A standard AI target selection rule for a person (called target) (this is the do not prefer high defence unless concentrated rule):
	let n be the defence of the target minus the melee of the main actor;
	if n is less than 0:
		now n is 0;
	let m be the concentration of main actor minus 1;
	[Negative if concentration = 0; 0 is concentration is 1; positive if concentration is 2 or 3.]
	increase the Weight by n times m;



Chapter - Second Stage - Choosing a Weapon

Table of AI Combat Weapon Options
Weapon	Weapon weight
a weapon	a number
with 50 blank rows

The standard AI weapon selection rules are a weapon based rulebook producing a number.
The standard AI weapon selection rulebook has a number called the Weight.

The chosen weapon is a weapon variable.

A Standard AI rule for a person (called P) (this is the select a weapon rule):
	if exactly one weapon is enclosed by P:
		now the chosen weapon is a random weapon enclosed by the global attacker;
	otherwise:
		blank out the whole of the Table of AI Combat Weapon Options;
		repeat with X running through all weapons enclosed by the P:
			let weight be the number produced by the standard AI weapon selection rules for X;
			choose a blank Row in the Table of AI Combat Weapon Options;
			now the Weapon entry is X;
			now the Weapon weight entry is weight;
		sort the Table of AI Combat Weapon Options in random order;
		sort the Table of AI Combat Weapon Options in reverse Weapon weight order;
		choose row 1 in the Table of AI Combat Weapon Options;
		now the chosen weapon is the Weapon entry;

Section - Standard rules

[ These rules are dependent on the W, and not whether they are being run for the attacker or the defender. It should be possible to determine who that is by checking who holds the weapon. ]

A standard AI weapon selection rule for a weapon (called W) (this is the prefer lots of damage rule):
	increase the Weight by the damage die of W;

A standard AI weapon selection rule for a weapon (called W) (this is the prefer low dodgability and passive parry rule):
	let n be the dodgability of the W;
	if the passive parry max of the W is greater than n:
		now n is the passive parry max of the W;
	decrease the Weight by n;

A standard AI weapon selection rule for a weapon (called W) (this is the prefer good active parry rule):
	increase the Weight by the active parry max of the W divided by 2;

A standard AI weapon selection rule for a weapon (called W) (this is the prefer good attack bonus rule):
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
A standard AI weapon selection rule for a weapon (called W) (this is the prefer readied weapon if attacker almost dead rule):
	if four times the health of the main actor is less than the permanent health of the main actor:
		if W is readied:
			increase the Weight by 2;

A standard AI weapon selection rule for a weapon (called W) (this is the prefer readied weapon if defender almost dead rule):
	if four times the health of the chosen target is less than the permanent health of the chosen target:
		if W is readied:
			increase the Weight by 2;

[A standard AI weapon selection rule (this is the randomise the weapon result rule):
	increase the Weight entry by a random number between 0 and 2.]

A last standard AI weapon selection rule (this is the return the weapon weight rule):
	rule succeeds with result Weight;

Section - Action selection rules

[For every possible action, there MUST be a "first" rule adding it to the table.]

First standard AI action selection rule for an at-Act person (called P) (this is the consider attacking rule):
	choose a blank Row in the Table of AI Combat Options;
	now the Option entry is the action of P attacking the chosen target;
	now the Action Weight entry is 5;

First standard AI action selection rule for a person (called P) (this is the consider concentrating rule):
	choose a blank Row in the Table of AI Combat Options;
	now the Option entry is the action of P concentrating;
	now the Action Weight entry is 3;

First standard AI action selection rule for an at-React person (called P) (this is the consider dodging rule):
	choose a blank Row in the Table of AI Combat Options;
	now the Option entry is the action of P dodging;
	now the Action Weight entry is 5;

First standard AI action selection rule for an at-React person (called P) (this is the consider parrying rule):
	choose a blank Row in the Table of AI Combat Options;
	now the Option entry is the action of P parrying;
	now the Action Weight entry is 5;

First standard AI action selection rule for a person (called P) when the chosen weapon is not readied (this is the consider readying rule):
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

First standard AI action selection rule (this is the calculate the chance to win rule):
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

Section - More action selection rules

A standard AI action selection rule for an at-Act person (called P) (this is the standard attack select rule):
	choose row with an Option of the action of the main actor attacking the chosen target in the Table of AI Combat Options;
	if the normalised chance-to-win is 0:
		now the Action Weight entry is -100;
	decrease the Action Weight entry by 5;
	increase the Action Weight entry by the normalised chance-to-win;

A standard AI action selection rule for a person (called P) (this is the standard concentration select rule):
	choose row with an Option of the action of P concentrating in the Table of AI Combat Options;
	increase the Action Weight entry by 5;
	decrease the Action Weight entry by the chance-to-win;
	if the concentration of P is 3:
		now the Action Weight entry is -100;

A standard AI action selection rule for an at-Act person (called P) (this is the concentration influences attacking rule):
	choose row with an Option of the action of the main actor attacking the chosen target in the Table of AI Combat Options;
	increase the Action Weight entry by the concentration of the chosen target;
	if the concentration of the chosen target is 3:
		increase the Action Weight entry by 2;

A standard AI action selection rule for an at-React person (called P) (this is the standard parry and dodge against attack select rule):
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

A standard AI action selection rule for a person (called P) when the chosen weapon is not readied (this is the don't attack or concentrate with an unreadied weapon rule):
	if P is at-Act:
		choose row with an Option of the action of P attacking the chosen target in the Table of AI Combat Options;
		now the Action Weight entry is -1000;
	choose row with an Option of the action of P concentrating in the Table of AI Combat Options;
	now the Action Weight entry is -100;
	[ Incorporated into this is the consider readying rule. ]
	[choose row with an Option of the action of P readying the chosen weapon in the Table of AI Combat Options;
	increase the Action Weight entry by 5;]

Last standard AI action selection rule (this is the randomise the action result rule):
	repeat through the Table of AI Combat Options:
		increase the Action Weight entry by a random number between 0 and 5;
[		say "[Option entry]: [Target weight entry][line break]"; [For testing]]



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
	if the current load time of the noun is the maximum load time of the noun:
		say "[The actor] [if the maximum load time of the noun is 1][reload text of the noun][s][otherwise]finish[es] [reload stem text of the noun]ing[end if] [the noun].";
	otherwise:
		say "[The actor] [if the current load time of the noun plus 1 is the maximum load time of the noun]start[s][otherwise]continue[s][end if] [reload stem text of the noun]ing [the noun].".



Section - Reloading and choosing a weapon

[Weapons with high load times and limited ammo should not be given a penalty if they are already readied and full; some penalty if they are not readied; and a larger penalty if they are not readied and out of ammo.]

[ Move unloaded into the preample? ]
Standard AI weapon selection rule for a weapon (called W) (this is the do not choose an empty weapon that cannot be reloaded rule):
	if the W is unloaded:
		if the maximum load time of the W is -1:
			decrease the Weight by 1000;

Standard AI weapon selection rule for a weapon (called W) (this is the do not prefer weapons that need to be reloaded rule):
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
First standard AI action selection rule for a person (called P) when the chosen weapon is waiting to be reloaded (this is the consider reloading rule):
	choose a blank Row in the Table of AI Combat Options;
	now the Option entry is the action of P reloading the chosen weapon;
	now the Action Weight entry is 5.

A standard AI action selection rule for a person (called P) when the chosen weapon is unloaded (this is the don't attack or concentrate with an unloaded weapon rule):
	if P is at-Act:
		choose row with an Option of the action of P attacking the chosen target in the Table of AI Combat Options;
		now the Action Weight entry is -1000;
	choose row with an Option of the action of P concentrating in the Table of AI Combat Options;
	now the Action Weight entry is -100;



Chapter - Tension (Standard Plug-in)

[Tension is a standard plug-in, since I believe almost any game will benefit from it. Tension is a kind of "drama manager" for combat: it makes sure that long periods in which no apparent progress is made--that is, in which no damage is done--are not experienced as boring, but rather as increasing the tension. The way it works is that every turn when no hit is scored, the tension (a number that varies) is increased by one. High tension gives everyone bonuses on the attack roll, thus increasing the likelihood that something will happen, and on the damage roll, thus increasing the stakes.

Tension also works as a check and balance on the combat system: if you have made it too hard for people to hit each other, tension will greatly alleviate this problem.]

The tension is a number that varies. The tension is usually 0.

Every turn (this is the standard increase or reset the tension rule):
	if the combat status is peace:
		now the tension is 0;
	otherwise:
		increase the tension by 1;
		if the tension is greater than 20:
			now the tension is 20.
	
A calculating the attack roll rule (this is the standard tension attack modifier rule):
	let the tension bonus be the tension divided by 2;
	if the tension bonus is not 0:
		if the numbers boolean is true:
			say " + ", the tension bonus, " (tension)[run paragraph on]";
		increase the roll by the tension bonus;
		
A dealing damage rule (this is the standard tension damage modifier rule):
	let the bonus be the tension divided by 3;
	if the bonus is not 0:
		if the numbers boolean is true:
			say " + ", the bonus, " (tension)[run paragraph on]";
		increase the damage by the bonus.

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

A standard AI action selection rule for an at-Act person (called P) (this is the tension influences attacking rule):
	choose row with an Option of the action of P attacking the chosen target in the Table of AI Combat Options;
	increase the Action Weight entry by the tension divided by 4.



Inform ATTACK ends here.