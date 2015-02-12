#!/usr/bin/env io
# Prototype for what takes place during a player's turn

Lobby doFile(Path with(System launchPath, "Cards.io"))

// TODO : Messaging to tell player what to do on turn

Turn := Object clone do(
	init := method(Player,
		self armies := 0
		self moves := 0
		self actionType := "N/A"
		self player := Player
		self done := false
	)
	init
	
	// TODO: Implement this
	takeTurn := method(Board,
		//1: buy card
		card := Market buyCard(0)
		player cards append(card)

		//2: processAction
		card action act(self)

		//3: doAction
		while(done not,
			if(actionType == "Army") then()
			elseif (actionType == "Move") then()
			elseif (actionType == "City") then(done = true)
			elseif (actionType == "Destroy") then(done = true)
			//AndOrAction
			else ()
		)

		//4: addAbility
		card ability affect(player)
	)

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
		purchased := available at(i)
		write(purchased, " bought for ", costs at(i), " coins.\n") 
		available remove(purchased)
		available append(Deck dealCard)
		purchased
	)
    show := method(
    	for(i, 0, 5,
    		write("(", available at(i), ", ", costs at(i), ") ")); 
    	"\n" print
    )
)

//Market show

/* Market Tests * 	
Market show 	
Market buyCard(1) 	
Market show 	
Market buyCard(2) 	
Market show
Market buyCard(3) 
**/

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
