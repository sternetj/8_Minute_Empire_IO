#!/usr/bin/env io

Flux

gameApp := Application clone
gameApp setTitle("8 Minute Empires: Legends")

/*
---
Dies on opening, anyone know why?
---
background := ImageView clone
background setImage(Image clone open(Path with(System launchPath, "../img/cover.jpg")))
gameApp mainWindow contentView addSubview(background) 
*/

Lobby doFile(Path with(System launchPath, "Cards.io"))

Market := Object clone do(
    init := method(
		self costs := list(0, 1, 1, 2, 2, 3)
		Deck shuffle
		self available := List clone
		for(i, 1, 6, available append(Deck dealCard))
	)
	init
	buyCard := method(i,
		write(available at(i), " bought for ", costs at(i), " coins.\n") 
		available remove(available at(i))
		available append(Deck dealCard)
	)
    show := method(
    	for(i, 0, 5,
    		write("(", available at(i), ", ", costs at(i), ") ")); 
    	"\n" print
    )
)

Market show
Market buyCard(1)
Market show
Market buyCard(2)
Market show
Market buyCard(3)

gameApp run