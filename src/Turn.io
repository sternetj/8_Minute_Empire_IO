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
		if(Deck cards size > 0, available append(Deck dealCard))
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

/*
TestPlayer := Player clone
TestPlayer init
c12 := Card clone 
c12 setslots("forest", nil, nil, "cursedmausoleum.png")
TestPlayer cards append(c12)

mab := MoveAbility clone 
aab := ArmyAbility clone
fab := FlyingAbility clone
eab := ElixirAbility clone 
anob := ScoreModifierAbilitynoble clone
cab := ScoreModifierAbilitycoin clone
mntab := ScoreModifierAbilitymount clone
ffab := ScoreModifierAbilityfly clone

smab := ScoreModifierAbility clone
//smab cat := "forest"
smab init("forest")


eab init(2)


write("InitPlayer: ", TestPlayer asString, "\n")
mab affect(TestPlayer)
write("After MoveAbility: ", TestPlayer asString, "\n")
aab affect(TestPlayer)
write("After ArmyAbility: ", TestPlayer asString, "\n")
fab affect(TestPlayer)
write("After FlyingAbility: ", TestPlayer asString, "\n")
eab affect(TestPlayer)
write("After ElixirAbility: ", TestPlayer asString, "\n")
anob affect(TestPlayer)
write("After ANAbility: ", TestPlayer asString, "\n")
write("score = ", TestPlayer getModifiedScore(0),"\n")
cab affect(TestPlayer)
write("After coinability: ", TestPlayer asString, "\n")
write("score = ", TestPlayer getModifiedScore(0),"\n")
mntab affect(TestPlayer)
write("After mntability: ", TestPlayer asString, "\n")
write("score = ", TestPlayer getModifiedScore(0),"\n")
ffab affect(TestPlayer)
write("After ffability: ", TestPlayer asString, "\n")
write("score = ", TestPlayer getModifiedScore(0),"\n")
smab affect(TestPlayer)
write("After ffability: ", TestPlayer asString, "\n")
write("score = ", TestPlayer getModifiedScore(0),"\n")
*/

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
