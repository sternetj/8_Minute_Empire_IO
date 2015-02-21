#!/usr/bin/env io

AbstractAbility := Object clone do(
	affect := method(Player,
		nil
	)
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
		Player elixirs = (Player elixirs + self nE)
	)
)

TreasuryAbility := AbstractAbility clone do(
	affect := method(Player,
		Player coins = ((Player coins) + 2)
		Player elixirs = ((Player elixirs) + 1)
	)
)

ScoreModifierAbility := AbstractAbility clone do(
	cat := nil
	init := method(cata, self cat := cata)

	affect := method(Player,
		Player scoreModifiers append( self cat )
	)
)

ScoreModifierAbilitynoble := AbstractAbility clone do(
	affect := method(Player,
		Player allnoble := 1;
	)
)

ScoreModifierAbilitycoin := AbstractAbility clone do(
	affect := method(Player,
		Player percoins := 1;
	)
)

ScoreModifierAbilitymount := AbstractAbility clone do(
	affect := method(Player,
		Player bothmount := 1;
	)
)

ScoreModifierAbilityfly := AbstractAbility clone do(
	affect := method(Player,
		Player perfly := 1;
	)
)

ImmuneAbility := AbstractAbility clone do(
	affect := method(Player,
		Player im := 1
	)
)
