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
		Player flyingMod = (1 max((Player flyingMod) - 1))
	)
)

ElixirAbility := AbstractAbility clone do(
	affect := method(Player,
		Player elixirs = ((Player elixirs) + 1)
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