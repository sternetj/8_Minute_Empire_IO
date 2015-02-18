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
	currentRound := nil
	startingPlayer := nil
	activePlayer := nil
	activeTurn := nil
	message := "Start game"

	init := method(
		self players := list()
		self board := Board
		self gameState := "Buy"
		self currentRound := 1
	)

	newGame := method(nPlayers,
		coins := if(nPlayers == 2, 14, if(nPlayers == 3, 11, 9))

		images := list("green.png", "blue.png", "red.png", "cyan.png")
		green := Color clone set(0, 1, 0, 1)
		blue := Color clone set(0, 0, 1, 1)
		red := Color clone set(1, 0, 0, 1)
		cyan := Color clone set(0, 1, 1, 1)
		colors := list(green, blue, red, cyan)
		names := list("Emerald Fairy Queen", "Azure Knight", "Crimson Sorceress", "Cyan Bandit King")

		for(i, 0, nPlayers - 1, 
			p := Player clone init(names at(i), coins, images at(i), colors at(i))
			self players append(p)
		)
		self maxRounds := if(nPlayers == 2, 13, if(nPlayers == 3,10,8))

		// In the real game players bid for first player
		// but we didn't want to have hidden information, 
		// so we just choose randomly
		self startingPlayer := Random value(0,nPlayers) floor
		self activePlayer := startingPlayer
		self activeTurn := Turn clone init(self players at(activePlayer))
		self message = self players at(activePlayer) .. " buy a card"
	)

	newTurn := method(
		self activePlayer = (self activePlayer + 1) % (self players size)
		if (self activePlayer == self startingPlayer, 
			self currentRound = self currentRound + 1
		)
		self activeTurn := Turn clone init(self players at(activePlayer))
		self message = self players at(activePlayer) .. " buy a card"
	)

	// getMessage := method(
	// 	self players at(activePlayer) icon image asString) println 
	// )

	// TODO: Game Loop!
)