#!/usr/bin/env io
# Contains the logic for maintaing the game state

Lobby doFile(Path with(System launchPath, "Board.io"))
Lobby doFile(Path with(System launchPath, "Player.io"))
Lobby doFile(Path with(System launchPath, "Turn.io"))

//Player1 := Player clone
//Player2 := Player clone
//Player3 := Player clone
//Player4 := Player clone
//Players := list(Player1, Player2, Player3, Player4)

Random setSeed(Date clone now asNumber)

Game := Object clone do(
	init := method(
		self players := list clone
		self board := Board
		self gameState := "Start"
		self currentTurn := 0
	)

	newGame := method(nPlayers,
		coins := if(nPlayers == 2) then(14)
				 elseif(nPlayers == 3) then(11)
				 else(9)

		for(p, 0, nPlayers, players append(Player clone init(coins)))
		self maxTurns := if(nPlayers == 2) then(13) 
						 elseif(nPlayers == 3) then(10)
						 else(8)

		// In the real game players bid for first player
		// but we didn't want to have hidden information, 
		// so we just choose randomly
		self startingPlayer := players at(Random value(0,nPlayers))
		self activePlayer := startingPlayer
		gameState = "Play"
	)

	//game loop
)