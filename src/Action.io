#!/usr/bin/env io
# Prototypes for Card Actions

AbstractAction := Object clone do(
	act := method(Turn,nil)
)

ArmyAction := Object clone do(
	init := method(n,
		self nArmies := n
	)

	act := method(Turn,
		Turn armies = (nArmies + (Turn player armyMod))
		Turn actionType := "Army"
	)
)

MoveAction := AbstractAction clone do(
	init := method(n,
		self nMoves := n
	)

	act := method(Turn,
		Turn moves = (nMoves + (Turn player moveMod))
		Turn actionType := "Move"
	)
)

CityAction := AbstractAction clone do(
	act := method(Turn,
		Turn actionType := "City"
	)
)

DestroyAction := AbstractAction clone do(
	act := method(
		Turn actionType := "Destroy"
	)
)

AndOrAction := AbstractAction clone do(
	init := method(a1, a2, oper,
		self operator := oper,
		self action1 := a1
		self action2 := a2)

	act := method(Turn,
		Turn actionType := operator toString
	)
)