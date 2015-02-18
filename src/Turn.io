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
		self
	)
	init
	
	// TODO: Implement this
	// TODO: check if they have enough money
	takeTurn := method(i,
		//1: buy card
		bought := Market buyCard(i)
		card := bought at(0)
		cost := bought at(1)
		player cards append(card)
		player coins = player coins - cost
		card ability affect(player)
		card action act(self)
		processAction
	)

	processAction := method(action,
		while(done not,
			Game gameState = "Action"
			Game message = player .. " : " .. if(actionType == "Army", armies .. " to place.",
									 		  if(actionType == "Move", moves .. " remaining.",
									 		  if(actionType == "Destroy", "destroy an army.",
									 		  if(actionType == "City", "place a city.","AndOr"))))
			done = true
		)
		Game newTurn
	)

	toString := method(
		"arm: " .. armies .. " type: " .. actionType .. " "
	)
)

Market := Object clone do(
    init := method(
		self costs := list(0, 1, 1, 2, 2, 3)
		r1 := Region clone
		r1 init("m1",0,210)
		r2 := Region clone
		r2 init("m2",170,210)
		r3 := Region clone
		r3 init("m3",340,210)
		r4 := Region clone
		r4 init("m4",510,210)
		r5 := Region clone
		r5 init("m5",680,210)
		r6 := Region clone
		r6 init("m6",850,210)
		self locations := list(r1,r2,r3,r4,r5,r6)
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
		list(purchased,costs at(i))
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
