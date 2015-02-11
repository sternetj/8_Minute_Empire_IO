#!/usr/bin/env io

AbstractAction := Object clone do(
	act := method(Turn,nil)
)

ArmyAction := Object clone do(
	init := method(n,
		self nArmies := n
	)

	act := method(Turn,
		Turn armies = ((Turn armies) + nArmies)
		Turn actionType := "Army"
	)
)

MoveAction := AbstractAction clone do(
	init := method(n,
		self nArmies := n
	)

	act := method(Turn,
		Turn armies = nArmies
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