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
		self actions := List clone
		self
	)
	init
	
	takeTurn := method(i,
		if (i == "EndAction") then (
			self doNextAction()
		) elseif (Game gameState == "Buy") then (
			// i is index of selected card
			if (-1 < player coins - Market costs at(i) and Market isCard(i)) then (
			bought := Market buyCard(i)
			card := bought at(0)
			cost := bought at(1)
			player cards append(card)
			player coins = player coins - cost
			card ability affect(player)
			card action act(self)
			processAction(card action))
		) elseif (Game gameState == "Army") then (
			//i is the region to add the army too
			if (i == Board regions at(Game startingRegion) or i castles at(Game activePlayer) > 0,
				mArmies := i armies
				mArmies atPut(Game activePlayer, mArmies at(Game activePlayer) + 1)
				i armies = mArmies

				self armies = armies - 1
			)
			writeln("Armies left: " .. armies)
			if (armies <= 0,
				writeln("doing next action")
				self doNextAction(),
				processAction(ArmyAction clone)
			)

		) elseif (Game gameState == "Move") then (
			// i is a list of indexs of fromRegion and toRegion
			path := Board regions at (i at(0)) getPath(Board regions at (i at(1)))
			path println
			pathSize := 0
			path foreach(edge,
				if(edge last, //water connection
					pathSize = pathSize + player getFlightCost
				, //land connection
					pathSize = pathSize + 1
				)
			)
			if (pathSize <= moves,
				self moves = moves - pathSize

				mArmies := Board regions at (i at(0)) armies
				mArmies atPut(Game activePlayer, mArmies at(Game activePlayer) - 1)
				Board regions at (i at(0)) armies = mArmies

				mArmies := Board regions at (i at(1)) armies
				mArmies atPut(Game activePlayer, mArmies at(Game activePlayer) + 1)
				Board regions at (i at(1)) armies = mArmies
			)
			if (moves == 0,
				self doNextAction(),
				processAction(MoveAction clone)
			)

		) elseif (Game gameState == "Destroy") then (
			self doNextAction()
		) elseif (Game gameState == "City") then (
			//TODO: can only place city if you have an army in the region
			//i is the region to add the city too
			if( i armies at(Game activePlayer) > 0,
			if (i castles at(Game activePlayer) == 0,
				mCastles := i castles
				mCastles atPut(Game activePlayer, 1)
				i castles = mCastles
				self doNextAction()
			))
		) elseif (Game gameState == "Or") then (
			//i is the index of the move to do
			actions at(i) act(self)
			processAction(actions at(i))
			self actions = list()
		) else (
			self doNextAction()
		)
	)

	processAction := method(action,
			if (actionType == "And") then (
				writeln("and action with first ".. action action1 asString)
 		  		action action1 act(self)
 		  		self actionType = action action1 actionType
 		  		self actions = list(action action2)
			) elseif (actionType == "Or") then (
 		  		self actions = list(action action1, action action2)
			)
			writeln("Now in state: " .. actionType)
 		  	Game gameState = actionType
			Game message = player .. " : " .. if(actionType == "Army", armies .. " armies to place.",
									 		  if(actionType == "Move", moves .. " remaining moves.",
									 		  if(actionType == "Destroy", "destroy an army.",
									 		  if(actionType == "City", "place a city.",
									 		  "Do you want to\n[1] " .. action action1 description .. " or\n[2] " .. action action2 description .. "?"))))
			writeln(Game message)
	)

	doNextAction := method(
		if (actions size > 0,
			writeln("action = " .. actions at(0) asString)
			self actions at(0) act(self)
			writeln("Now state = " .. Turn toString)
			self processAction(actions at(0))
			self actions remove(actions at(0)),
			Game newTurn
		)
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
		
		//add empty cards to the back of the deck
		cardback := Card clone
    	cardback init(nil, nil, nil, "cardback.png")
	    for(i, 0, 6, Deck cards insertAt(cardback, 0))
		
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
	isCard := method(i,
		card := available at(i)
		card category != nil
	)
    show := method(
    	for(i, 0, 5,
    		write("(", available at(i), ", ", costs at(i), ") ")); 
    	"\n" print
    )
)