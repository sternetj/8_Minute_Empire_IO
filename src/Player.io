#!/usr/bin/env io
# Prototype representing the current state of a player

Player := Object clone do(
	init := method(
		self coins := 0
		self moveMod := 0
		self armyMod := 0
		self flyingMod := 0 //Can have > 3 (one card for VP, can only reduce cost to 1 though)
		self elixirs := 0
		self scoreModifiers := list clone
		self cards := list clone
	)
	toString := method(
		"C: " .. coins .. " MM: " .. moveMod .. " AM: " .. armyMod .. " FM: " .. flyingMod .. " Elxr: ", elixirs
	)

	//Not tested
	getModifiedScore := method(score,
		foreach(mod, score = score + mod)
		score
	)

	//Not tested
	getFlightCost := method(
		1 max(3 - flyingMod)
	)

	//board stuff?
)