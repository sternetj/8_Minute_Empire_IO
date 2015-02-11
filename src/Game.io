#!/usr/bin/env io
# Contains the logic for maintaing the game state

Lobby doFile(Path with(System launchPath, "Board.io"))
Lobby doFile(Path with(System launchPath, "Player.io"))
Lobby doFile(Path with(System launchPath, "Turn.io"))

Player1 := Player clone
Player2 := Player clone
Player3 := Player clone
Player4 := Player clone
Players := list(Player1, Player2, Player3, Player4)

Random setSeed(Date clone now asNumber)

Game := Object clone do(
	init := method(Players,Board,
		self players := Players
		self board := Board
		self maxTurns := if(players size == 2) then(13) elseif(players size == 3) then(10) else(8)
		self currentTurn := 0
		self startingPlayer := players at(Random value(0,4))
		self activePlayer := startingPlayer
	)

	//game loop
)