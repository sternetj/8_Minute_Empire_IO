#!/usr/bin/env io
# Prototype representing the current state of a player

Player := Object clone do(

	init := method(name, startCoins,imgName,color,
		self score := 0
		self name := name		
		self coins := startCoins
		self moveMod := 0
		self armyMod := 0
		self flyingMod := 0
		self elixirs := 0
		self scoreModifiers := list clone
		self cards := list clone
		self allnoble := 0
		self bothmount := 0
		self percoins := 0
		self perfly := 0
		self icon := ImageWrapper new(imgName, 28, 24)
		self color := color
		self
	)

	asString := method(
		name
		//"C: " .. coins .. " MM: " .. moveMod .. " AM: " .. armyMod .. " FM: " .. flyingMod .. " Elxr: " .. elixirs .."\n ALN: " .. allnoble .. " BM: ".. bothmount .. " PC: ".. percoins .. " PF: ".. perfly .. " SM: " .. scoreModifiers
	)

	getModifiedScore := method(score,
		if(perfly == 1, score = score + flyingMod)

		if(percoins == 1, score = score + (self coins / 3)*percoins)

		if(allnoble == 1, 
			self k := 0
			self cards foreach(i,v, 
				if(v category == "noble", self k = self k + 1)
			)
			if (self k == 3, score = score + 4))

		if(bothmount == 1, 
			self k := 0
			self cards foreach(i,v, 
				if (v category == "mountain", self k = self k + 1)
			) 
			if (self k == 3, score = score +3))

		self scoreModifiers foreach(i, mod, 
			self cards foreach(j, card, 
				if (card category == mod, score = score +1)
			)
		)

		score
	)

	getFlightCost := method(
		1 max(3 - flyingMod)
	)
)
