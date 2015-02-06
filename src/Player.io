#!/usr/bin/env io

Player := Object clone do(
	init := method(
		self coins := 0
		self moveMod := 0
		self armyMod := 0
		self flyingMod := 3
		self elixirs := 0
		self scoreModifiers := list clone
	)
	toString := method(
		"C: " .. coins .. " MM: " .. moveMod .. " AM: " .. armyMod .. " FM: " .. flyingMod .. " Elxr: ", elixirs
	)
	//need scoring methods and other board related-stuff
)