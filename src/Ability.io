#!/usr/bin/env io

AbstractAbility := Object clone do(
	affect := method(Player,nil)
)

MoveAbility := AbstractAbility clone do(
	affect := method(Player,
		Player moveMod = ((Player moveMod) + 1)
	)
)

ArmyAbility := AbstractAbility clone do(
	affect := method(Player,
		Player armyMod = ((Player armyMod) + 1)
	)
)

FlyingAbility := AbstractAbility clone do(
	affect := method(Player,
		Player flyingMod = ((Player flyingMod) + 1)
	)
)

ElixirAbility := AbstractAbility clone do(
	init := method(n,
		self nE := n
	)
	affect := method(Player,
		Player elixirs = ((Player elixirs) + nE)
	)
)

CoinsAbility := AbstractAbility clone do(
	affect := method(Player,
		Player coins = ((Player coins) + 2)
	)
)

ScoreModifierAbility := AbstractAbility clone do(
	affect := method(Player, scoreFn
		Player scoreModifiers append(scoreFn)
	)
)

ImmuneAbility := AbstractAbility clone do(
	affect := method(Player,
		Player im := 1
	)
)