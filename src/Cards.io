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

Card := Object clone do(
    init := method(cat,act,abil,img,
        self category := cat
        self action := act
        self ability := abil
        self image := img
    )

    setslots := method(cat,act,abil,img,
        self category := cat
        self action := act
        self ability := abil
        self image := img
    )

    toString := method(
        "type: " .. category .. " image: " .. image .. " "
    )
)

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
    
    c2 := Card clone 
    c2 setslots("ancient",
    ArmyAction clone init(4), ElixirAbility clone init(3),
 "ancienttreespirit.png")
    cards append(c2)
    
    c3 := Card clone 
    c3 setslots("ancient", AndOrAction clone init( ArmyAction clone init(1),CityAction clone init(1), "and"), 
    ArmyAbility clone,
    "ancientwoods.png")
    cards append(c3)

    c4 := Card clone 
    c4 setslots("arcane", ArmyAction clone init(4), MoveAbility clone, "arcanemanticore.png")
    cards append(c4)

    c5 := Card clone 
    c5 setslots("arcane", AndOrAction clone init( ArmyAction clone init(3),MoveAction clone init(4), "or"), FlyingAbility clone, "arcanesphinx.png")
    cards append(c5)

    c6 := Card clone 
    c6 setslots("arcane", MoveAction clone init(3), ScoreModifierAbility clone, "arcanetemple.png")
    cards append(c6)

    c7 := Card clone 
    c7 setslots("castle", AndOrAction clone init( ArmyAction clone init(3),CityAction clone init(1), "or"), ElixirAbility clone init(1), "castle1.png")
    cards append(c7)

    c8 := Card clone 
    c8 setslots("castle", AndOrAction clone init( MoveAction clone init(3),CityAction clone init(1), "and"), ElixirAbility clone init(1), "castle2.png")
    cards append(c8)

    c9 := Card clone 
    c9 setslots("cursed",  MoveAction clone init(6), ElixirAbility clone init(2), "cursedbanshee.png")
    cards append(c9)

    c10 := Card clone 
    c10 setslots("cursed",  MoveAction clone init(5), FlyingAbility clone init(2), "cursedgargoyles.png")
    cards append(c10)

    c11 := Card clone 
    c11 setslots("cursed",  AndOrAction clone init( MoveAction clone init(4),ArmyAction clone init(3), "or"), ElixirAbility clone init(1), "cursedking.png")
    cards append(c11)

    c12 := Card clone 
    c12 setslots("cursed",  CityAction clone init(1), MoveAbility clone, "cursedmausoleum.png")
    cards append(c12)

    c13 := Card clone 
    c13 setslots("cursed",  CityAction clone init(1), ScoreModifierAbility clone, "cursedtower.png")
    cards append(c13)

    c14 := Card clone 
    c14 setslots("dire",  AndOrAction clone init( DestroyAction clone ,ArmyAction clone init(3), "and"), FlyingAbility clone, "diredragon.png")
    cards append(c14)

    c15 := Card clone 
    c15 setslots("dire",  ArmyAction clone init(4), FlyingAbility clone, "direeye.png")
    cards append(c15)

    c16 := Card clone 
    c16 setslots("dire",  AndOrAction clone init( DestroyAction clone ,ArmyAction clone init(3), "and"), ImmuneAbility clone, "diregiant.png")
    cards append(c16)

    c17 := Card clone 
    c17 setslots("dire",  MoveAction clone init(5), ElixirAbility clone init(1), "diregoblin.png")
    cards append(c17)

    c18 := Card clone 
    c18 setslots("dire",  MoveAction clone init(2), ScoreModifierAbility clone, "direogre.png")
    cards append(c18)

    c19 := Card clone 
    c19 setslots("forest",  AndOrAction clone init(MoveAction clone init(2) ,ArmyAction clone init(3), "or"), ArmyAbility clone, "forestelf.png")
    cards append(c19)

    c20 := Card clone 
    c20 setslots("forest",  MoveAction clone init(2), ElixirAbility clone init(3), "forestgnome.png")
    cards append(c20)

   c21 := Card clone 
    c21 setslots("forest",  MoveAction clone init(4), ArmyAbility clone, "forestpixie.png")
    cards append(c21)

    c22 := Card clone 
    c22 setslots("forest",  CityAction clone init(4), MoveAbility clone, "foresttreetown.png")
    cards append(c22)  

    c23 := Card clone 
    c23 setslots("cursed",  ArmyAction clone init(4), ScoreModifierAbility clone, "graveyard.png")
    cards append(c23)       

    c24 := Card clone 
    c24 setslots("forest", AndOrAction clone init(MoveAction clone init(3) ,ArmyAction clone init(2), "or"), ScoreModifierAbility clone, "lake.png")
    cards append(c24) 

    c25 := Card clone 
    c25 setslots("mountain", AndOrAction clone init(DestroyAction clone ,ArmyAction clone init(2), "and"), ScoreModifierAbility clone, "mountaindwarf.png")
    cards append(c25) 

    c26 := Card clone 
    c26 setslots("mountain", MoveAction clone init(3), CoinsAbility clone, "mountaintreasury.png")
    cards append(c26) 

    c27 := Card clone 
    c27 setslots("night", AndOrAction clone init(DestroyAction clone ,ArmyAction clone init(5), "and"), ArmyAbility clone, "nighthydra.png")
    cards append(c27) 

    c28 := Card clone 
    c28 setslots("night", CityAction clone, ArmyAbility clone, "nightvillage.png")
    cards append(c28) 

    c29 := Card clone 
    c29 setslots("night", AndOrAction clone init(DestroyAction clone ,ArmyAction clone init(3), "and"), ArmyAbility clone, "nightwizard.png")
    cards append(c29) 

     c30 := Card clone 
    c30 setslots("noble", ArmyAction clone init(3), ScoreModifierAbility clone, "noblehills.png")
    cards append(c30)  

     c31 := Card clone 
    c31 setslots("noble", AndOrAction clone init(DestroyAction clone ,ArmyAction clone init(4), "and"), MoveAbility clone, "nobleknight.png")
    cards append(c31)   

    c32 := Card clone 
    c32 setslots("noble", AndOrAction clone init(MoveAction clone init(4) ,ArmyAction clone init(1), "and"), MoveAbility clone, "nobleunicorn.png")
    cards append(c32)     

    c33 := Card clone 
    c33 setslots("dire", CityAction clone, ScoreModifierAbility clone, "stronghold.png")
    cards append(c33)           

    )

    init
    shuffle  := method(cards shuffle)
    dealCard := method(cards pop)
    show := method(cards map(card, write(card toString, " \n")); "\n" print)
)

cs := Deck show

