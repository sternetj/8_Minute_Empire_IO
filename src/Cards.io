#!/usr/bin/env io

Lobby doFile(Path with(System launchPath, "Action.io"))
Lobby doFile(Path with(System launchPath, "Ability.io"))

// Below is the the sample cards class

Random setSeed(Date clone now asNumber)

List shuffle := method(
    for(i, 1, size - 1, 
	swapIndices(i, Random value(0, size) floor)
    )
)

Deck := Object clone do(
    init := method(
	self cards := List clone
	list("h", "d", "c", "s") foreach(suit, 
	    for(value, 2, 14, cards append(value asString .. suit))
	   )
    )
    init
    shuffle  := method(cards shuffle)
    dealCard := method(cards pop)
    show := method(cards foreach(i, card, write(card, " ")); "\n" print)
)
