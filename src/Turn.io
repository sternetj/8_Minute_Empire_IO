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
	
	// TODO: Implement this
	// TODO: check if they have enough money
	takeTurn := method(i,
		if (i == "EndAction") then (
			self doNextAction()
		) elseif (Game gameState == "Buy") then (
			// i is index of selected card
			bought := Market buyCard(i)
			card := bought at(0)
			cost := bought at(1)
			player cards append(card)
			player coins = player coins - cost
			card ability affect(player)
			card action act(self)
			processAction(card action)
		) elseif (Game gameState == "Army") then (
			//i is the region to add the city too
			if (i castles at(Game activePlayer) > 0 or i == Board regions at(Game startingRegion),
				mArmies := i armies
				mArmies atPut(Game activePlayer, mArmies at(Game activePlayer) + 1)
				i armies = mArmies

				self armies = armies - 1
			)

			if (armies == 0,
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

		) elseif (Game gameState == "City") then (
			//TODO: can only place city if you have an army in the region
			//i is the region to add the city too
			if (i castles at(Game activePlayer) == 0,
				mCastles := i castles
				mCastles atPut(Game activePlayer, 1)
				i castles = mCastles
				self doNextAction()
			)
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
 		  		action action1 act(self)
 		  		self actionType = action action1 actionType
 		  		self actions = list(action action2)
			) elseif (actionType == "Or") then (
 		  		self actions = list(action action1, action action2)
			)
			writeln(actionType)
 		  	Game gameState = actionType
			Game message = player .. " : " .. if(actionType == "Army", armies .. " armies to place.",
									 		  if(actionType == "Move", moves .. " remaining moves.",
									 		  if(actionType == "Destroy", "destroy an army.",
									 		  if(actionType == "City", "place a city.",
									 		  "Do you want to [1] " .. action action1 description .. "\n or [2] " .. action action2 description .. "?"))))
	)

	doNextAction := method(
		if (actions size > 0,
			self actions at(0) act(self)
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