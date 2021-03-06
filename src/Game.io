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
	startingRegion := nil

	init := method(
		self players := list()
		self board := Board
		self gameState := "Buy"
		self currentRound := 1
		//Starting Regions satisfy 2 properties:
		// 1) It has a water connection to another continent
		// 2) It's adjacent to a region with a water connection to another continent;
		//     OR it has an additional water connection to another continent
		// In our static board, only r5, r6, r8, r9, and r10 are eligible starting positions
		self startingRegion := (list(5,6,8,9,10) at((Random value(0,5) floor))) - 1
	)

	newGame := method(nPlayers,
		coins := if(nPlayers == 2, 14, if(nPlayers == 3, 11, 9))
		self maxRounds := if(nPlayers == 2, 13, if(nPlayers == 3,10,8))
		images := list("green.png", "blue.png", "red.png", "cyan.png")
		green := Color clone set(0, 1, 0, 1)
		blue := Color clone set(0, 0, 1, 1)
		red := Color clone set(1, 0, 0, 1)
		cyan := Color clone set(0, 1, 1, 1)
		colors := list(green, blue, red, cyan)
		names := list("Emerald Fairy Queen", "Azure Knight", "Crimson Sorceress", "Cyan Bandit King")

		for(i, 0, nPlayers - 1, 
			p := Player clone init(names at(i), coins, images at(i), colors at(i))
			//give each player some cards (testing)
			//for(j, 0, 12, p cards append(Market buyCard(0) at(0)))
			self players append(p)
			Board regions at(startingRegion) armies atPut(i,4) 
		)

		// In the real game players bid for first player
		// but we didn't want to have hidden information, 
		// so we just choose randomly
		self startingPlayer := Random value(0,nPlayers) floor
		self activePlayer := startingPlayer
		self activeTurn := Turn clone init(self players at(activePlayer))
		self message = self players at(activePlayer) .. " buy a card"
	)

	newTurn := method(
		self gameState := "Buy"
		self activePlayer = (self activePlayer + 1) % (self players size)
		if (self activePlayer == self startingPlayer, 
			self currentRound = self currentRound + 1
		)
		if(gameOver,
			self gameState := "GameOver"
			calculateScores,
			
			self activeTurn := Turn clone init(self players at(activePlayer))
			self message = self players at(activePlayer) .. " buy a card"
		)
	)

	gameOver := method(
		if(players size == 2,
			self currentRound > 0,
		if(players size == 3,
			self currentRound > 10,
		if(players size == 4,
			self currentRound > 8)))
	)

	calculateScores := method(
		continentCounts := Map clone with("N", list(0,0,0,0), "W", list(0,0,0,0), "S", list(0,0,0,0), "E", list(0,0,0,0), "Island", list(0,0,0,0))
		board regions foreach(r,
			continentCounts atPut(r continent,
				temp := continentCounts at(r continent) clone
				for(i, 0, 3,
					temp atPut(i, temp at(i) + r armies at(i))
				)
				temp
			)
		)

		elixirs := list(0,0,0,0)
		self players foreach(i,p,
			elixirs atPut(i, p elixirs)
		)
		maxElixirs := elixirs max
		maxElixirCount := elixirs select(v, v == maxElixirs) size

		self players foreach(i, p,
			score := 0
			//Regions
			board regions foreach(r,
				maxArmies := r armies max
				maxArmyCount := r armies select(v, v == maxArmies) size
				if(maxArmies = r armies at(i) and maxArmyCount == 1, score = score + 1)
			)

			//Continents
			continentCounts values foreach(contArmies,
				maxContArmies := contArmies max
				maxContArmyCount := contArmies select(v, v == maxContArmies) size
				if(maxContArmies == r armies at(i) and maxContArmyCount == 1, score = score + 1)
			)

			//Abilities
			score = p getModifiedScore(score)

			//Elixirs
			if(maxElixirs == elixirs at(i) and maxElixirCount == 1, score + 2,
			if(maxElixirs == elixirs at(i), score + 1, score))

			p score = score
		)

		winner := players at(0)
		self players foreach(p,
			if(winner score > p score,
				winner = p)
		)

		winners := List clone
		self players foreach(p,
			if(winner score == p score,
				winners append(p))
		)
		if(winners size > 1,
			self message = "Winners are " .. for(i, 0, winners size - 2, winners at(i) .. " & ") .. winners at(winners size - 1) .. " with " .. winner score  .. if(winner score == 1, " point", " points"),
			self message = "Winner is " .. winner .. " with " .. winner score .. if(winner score == 1, " point", " points")
		)
	)
)