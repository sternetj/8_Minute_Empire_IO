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