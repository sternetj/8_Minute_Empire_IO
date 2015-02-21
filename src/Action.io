#!/usr/bin/env io
# Prototypes for Card Actions

AbstractAction := Object clone do(
	actionType := "ActionType"
	description := "Description"

	act := method(Turn,
		nil
	)
)

ArmyAction := AbstractAction clone do(
	actionType := "Army"

	init := method(n,
		self nArmies := n
		self description := "place " .. n .. " armies"
	)

	act := method(Turn,
		Turn armies = (nArmies + (Turn player armyMod))
		Turn actionType := "Army"
		writeln("adding " .. nArmies .. " to turn")
	)
)

MoveAction := AbstractAction clone do(
	actionType := "Move"

	init := method(n,
		self nMoves := n
		self description := "move " .. n .. " armies"
	)

	act := method(Turn,
		Turn moves = (nMoves + (Turn player moveMod))
		Turn actionType := "Move"
	)
)

CityAction := AbstractAction clone do(
	actionType := "City"
	description := "place a new castle"

	act := method(Turn,
		Turn actionType := "City"
	)
)

DestroyAction := AbstractAction clone do(
	actionType := "Destroy"
	description := "destroy an army"

	act := method(Turn,
		
		Turn actionType = "Destroy"
		writeln("in destroy action " .. Turn toString)
	)
)

AndOrAction := AbstractAction clone do(
	actionType := "AndOr"
	
	init := method(a1, a2, oper,
		self operator := oper
		self action1 := a1
		self action2 := a2)

	act := method(Turn,
		Turn actionType := operator
	)
)

/* Don't know if we want to split these or not
OrAction := AbstractAction clone do(
	init := method(a1, a2,
		self action1 := a1
		self action2 := a2)

	act := method(Turn,
		Turn actionType := "Or"
	)
)

AndAction := AbstractAction clone do(
	init := method(a1, a2,
		self action1 := a1
		self action2 := a2)

	act := method(Turn,
		Turn actionType := "And"
	)
)
*/