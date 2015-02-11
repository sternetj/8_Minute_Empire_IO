#!/usr/bin/env io

Lobby doFile(Path with(System launchPath, "Cards.io"))

Turn := Object clone do(
	init := method(Player,
		self armies := 0
		self actionType := "N/A"
		self player := Player
	)
	init
	//do stuff with the board
	takeTurn := method()
	toString := method(
		"arm: " .. armies .. " type: " .. actionType .. " "
	)
)

Market := Object clone do(
    init := method(
		self costs := list(0, 1, 1, 2, 2, 3)
		Deck shuffle
		self available := List clone
		for(i, 1, 6, available append(Deck dealCard))
	)
	init
	buyCard := method(i,
		write(available at(i), " bought for ", costs at(i), " coins.\n") 
		available remove(available at(i))
		available append(Deck dealCard)
	)
    show := method(
    	for(i, 0, 5,
    		write("(", available at(i), ", ", costs at(i), ") ")); 
    	"\n" print
    )
)


Market show




/* Ability Tests *
TestPlayer := Player clone
mab := MoveAbility clone
aab := ArmyAbility clone
fab := FlyingAbility clone
eab := ElixirAbility clone

write("InitPlayer: ", TestPlayer toString, "\n")
mab affect(TestPlayer)
write("After MoveAbility: ", TestPlayer toString, "\n")
aab affect(TestPlayer)
write("After ArmyAbility: ", TestPlayer toString, "\n")
fab affect(TestPlayer)
write("After FlyingAbility: ", TestPlayer toString, "\n")
eab affect(TestPlayer)
write("After ElixirAbility: ", TestPlayer toString, "\n")
**/

/* Action Tests *
TestActionPlayer := Player clone
TestTurn := Turn clone
TestTurn init(TestActionPlayer)
aac := ArmyAction clone 
aac init(2)
mac := MoveAction clone 
mac init(3)
cac := CityAction clone
dac := DestroyAction clone
oac := OrAction clone 
oac init(dac,cac)

write("InitTurn: ", TestTurn toString, "\n")
aac act(TestTurn)
write("After ArmyAction: ", TestTurn toString, "\n")
mac act(TestTurn)
write("After MoveAction: ", TestTurn toString, "\n")
cac act(TestTurn)
write("After CityAction: ", TestTurn toString, "\n")
dac act(TestTurn)
write("After DestroyAction: ", TestTurn toString, "\n")
oac act(TestTurn)
write("After OrAction: ", TestTurn toString, " a1: ", oac action1, " a2: ", oac action2, "\n")
**/
