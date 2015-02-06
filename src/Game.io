#!/usr/bin/env io

Flux

gameApp := Application clone
gameApp setTitle("8 Minute Empires: Legends")

/*
--------------------------------
Dies on opening, anyone know why?
--------------------------------

background := ImageView clone
background setImage(Image clone open(Path with(System launchPath, "../img/cover.jpg")))
gameApp mainWindow contentView addSubview(background) 
*/

Lobby doFile(Path with(System launchPath, "Player.io"))
Lobby doFile(Path with(System launchPath, "Turn.io"))

Player1 := Player clone
Player2 := Player clone
Player3 := Player clone
Player4 := Player clone
Players := list(Player1, Player2, Player3, Player4)

gameApp run