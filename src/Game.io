#!/usr/bin/env io
# Contains the logic for maintaing the game state

Lobby doFile(Path with(System launchPath, "Board.io"))
Lobby doFile(Path with(System launchPath, "Player.io"))
Lobby doFile(Path with(System launchPath, "Turn.io"))

Random setSeed(Date clone now asNumber)

Game := Object clone do(
	players := nil
	board := nil
	gameState := nil
	currentTurn := nil
	startingPlayer := nil
	activePlayer := nil
	
	init := method(
		self players := list()
		self board := Board
		self gameState := "Start"
		self currentTurn := 0
	)

	newGame := method(nPlayers,
		coins := if(nPlayers == 2) then(
					14
				 )elseif(nPlayers == 3) then(
				 	11
				 )else(
				 	9
				 )

		images := list("green.png", "blue.png", "magenta.png", "yellow.png")

		for(i, 0, nPlayers, 
			p := Player clone 
			p init(coins, images at(i))
			self players append(p)
		)
		self maxTurns := if(nPlayers == 2) then(
							13
						 )elseif(nPlayers == 3) then(
						 	10
						 )else(
						 	8
						 )

		// In the real game players bid for first player
		// but we didn't want to have hidden information, 
		// so we just choose randomly
		self startingPlayer := players at(Random value(0,nPlayers) floor)
		self activePlayer := startingPlayer
		gameState = "Play"
	)

	// TODO: Game Loop!
)