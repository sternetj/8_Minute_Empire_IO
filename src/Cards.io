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

Card := Object clone
Card catagory := nil
Card action := nil
Card ability := nil
Card image := nil
Card setslots := method(cat,act,abil,img,
        self catagory := cat
        self action := act
        self ability := abil
        self image := img)
Card toString := method("type: " .. catagory .. " image: " .. image .. " ")

Deck := Object clone do(
    init := method(
	self cards := List clone
	
    c0 := Card clone 
    c0 setslots("ancient", MoveAction clone init(5), FlyingAbility clone, "ancientphoenix.png")
    
    cards append(c0)

    c1 := Card clone 
    c1 setslots("ancient",
    MoveAction clone init(3), ScoreModifierAbility clone,
    "ancientsage.png")
    cards append(c1)
    
    c2 :=Card clone 
    c2 setslots("ancient",
    ArmyAction clone init(4), ElixirAbility clone init(3),
 "ancienttreespirit.png")
    cards append(c2)
    
    c3 := Card clone 
    c3 setslots("ancient", AndAction init( ArmyAction clone init (1),CityAction clone init (1)), 
    ArmyAbility clone,
    "ancientwoods.png")
    cards append(c3)

    c4 := Card clone 
    c4 setslots("arcane", ArmyAction clone init(4), MoveAbility clone, "arcanemanticore.png")
    cards append(c4)

    )

    init
    shuffle  := method(cards shuffle)
    dealCard := method(cards pop)
    show := method(cards map(card, write(card toString, " \n")); "\n" print)
)

cs := Deck show

