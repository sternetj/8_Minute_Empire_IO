#!/usr/bin/env io
# Prototype for 8ME cards

Lobby doFile(Path with(System launchPath, "Action.io"))
Lobby doFile(Path with(System launchPath, "Ability.io"))

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

    asString := method(
        "type: " .. category .. " image: " .. image .. " "
    )
)

// TODO: do we need to handle the deck running out of cards? 
Deck := Object clone do(
    init := method(
	    self cards := List clone

        //Army Abilities
        a1 := ArmyAction clone
        a1 init(1)
        a2 := ArmyAction clone
        a2 init(2)
        a3 := ArmyAction clone
        a3 init(3)
        a4 := ArmyAction clone
        a4 init(4)
        a5 := ArmyAction clone
        a5 init(5)

        //Move Abilities
        m2 := MoveAction clone
        m2 init(2)
        m3 := MoveAction clone
        m3 init(3)
        m4 := MoveAction clone
        m4 init(4)
        m5 := MoveAction clone
        m5 init(5)
        m6 := MoveAction clone
        m6 init(6)

        //Elixir Abilities
        e1 := ElixirAbility clone
        e1 init(1)
        e2 := ElixirAbility clone
        e2 init(2)
        e3 := ElixirAbility clone
        e3 init(3)

        //Other Actions/Abilities
        ca := CityAction clone
        da := DestroyAction clone
        ma := MoveAbility clone
        aa := ArmyAbility clone
        fa := FlyingAbility clone
        ta := TreasuryAbility clone
        ia := ImmuneAbility clone

        
        c0 := Card clone 
        c0 setslots("ancient", m5, fa, "ancientphoenix.png")
        cards append(c0)

        c1 := Card clone 
        fn1 := ScoreModifierAbility clone 
        fn1 init("ancient")
        c1 setslots("ancient", m3, fn1, "ancientsage.png")
        cards append(c1)
        
        c2 := Card clone 
        c2 setslots("ancient", a4, e3,"ancienttreespirit.png")
        cards append(c2)
        
        c3 := Card clone 
        ao3 := AndOrAction clone
        ao3 init(ca, a1, "And")
        c3 setslots("ancient", ao3, aa, "ancientwoods.png")
        cards append(c3)

        c4 := Card clone 
        ao4 := AndOrAction clone
        ao4 init(a4, da, "And")
        c4 setslots("arcane", ao4, ma, "arcanemanticore.png")
        cards append(c4)

        c5 := Card clone 
        ao5 := AndOrAction clone
        ao5 init(a3, m4, "Or")
        c5 setslots("arcane", ao5, fa, "arcanesphinx.png")
        cards append(c5)

        c6 := Card clone
        fn6 := ScoreModifierAbility clone 
        fn6 init("arcane")
        c6 setslots("arcane", m3, fn6, "arcanetemple.png")
        cards append(c6)

        c7 := Card clone 
        ao7 := AndOrAction clone
        ao7 init(a3, ca, "Or")
        c7 setslots("castle", ao7, e1, "castle1.png")
        cards append(c7)

        c8 := Card clone 
        ao8 := AndOrAction clone
        ao8 init(m3, ca, "And")
        c8 setslots("castle", ao8, e1, "castle2.png")
        cards append(c8)

        c9 := Card clone 
        c9 setslots("cursed", m6, e2, "cursedbanshee.png")
        cards append(c9)

        c10 := Card clone 
        c10 setslots("cursed", m5, fa, "cursedgargoyles.png")
        cards append(c10)

        c11 := Card clone 
        ao11 := AndOrAction clone
        ao11 init(a3, m4, "Or")
        c11 setslots("cursed", ao11, e1, "cursedking.png")
        cards append(c11)

        c12 := Card clone 
        c12 setslots("cursed", ca, ma, "cursedmausoleum.png")
        cards append(c12)

        c13 := Card clone 
        fn13 := ScoreModifierAbilityfly clone
        c13 setslots("cursed", ca, fn13, "cursedtower.png")
        cards append(c13)

        c14 := Card clone 
        ao14 := AndOrAction clone
        ao14 init(a3, da, "And")
        c14 setslots("dire", ao14, fa, "diredragon.png")
        cards append(c14)

        c15 := Card clone 
        c15 setslots("dire", a4, fa, "direeye.png")
        cards append(c15)

        c16 := Card clone 
        ao16 := AndOrAction clone
        ao16 init(a3, da, "And")
        c16 setslots("dire", ao16, ia, "diregiant.png")
        cards append(c16)

        c17 := Card clone 
        c17 setslots("dire", m5, e1, "diregoblin.png")
        cards append(c17)

        c18 := Card clone 
        fn18 := ScoreModifierAbilitycoin clone
        c18 setslots("dire", m2, fn18, "direogre.png")
        cards append(c18)

        c19 := Card clone 
        ao19 := AndOrAction clone
        ao19 init(a3, m2, "Or")
        c19 setslots("forest", ao19, aa, "forestelf.png")
        cards append(c19)

        c20 := Card clone 
        c20 setslots("forest", m2, e3, "forestgnome.png")
        cards append(c20)

        c21 := Card clone 
        c21 setslots("forest", m4, aa, "forestpixie.png")
        cards append(c21)

        c22 := Card clone 
        c22 setslots("forest", ca, ma, "foresttreetown.png")
        cards append(c22)  

        c23 := Card clone 
        fn23 := ScoreModifierAbility clone 
        fn23 init( "cursed")

        c23 setslots("graveyard", a2, fn23, "graveyard.png")
        cards append(c23)       

        c24 := Card clone
        ao24 := AndOrAction clone
        ao24 init(a2, m3, "Or")
        fn24 := ScoreModifierAbility 
        fn24 clone init("forest")
        //Doesn't count itself
        c24 setslots("lake", ao24, fn24, "lake.png")
        cards append(c24) 

        c25 := Card clone 
        ao25 := AndOrAction clone
        ao25 init(a2, da, "And")
        fn25 := ScoreModifierAbility clone 
        fn25 init("mountain")

        c25 setslots("mountain", ao25, fn24, "mountaindwarf.png")
        cards append(c25) 

        c26 := Card clone 
        c26 setslots("mountain", m3, ta, "mountaintreasury.png")
        cards append(c26) 

        c27 := Card clone 
        ao27 := AndOrAction clone
        ao27 init(m5, da, "And")
        c27 setslots("night", ao27, aa, "nighthydra.png")
        cards append(c27) 

        c28 := Card clone 
        c28 setslots("night", ca, aa, "nightvillage.png")
        cards append(c28) 

        c29 := Card clone
        ao29 := AndOrAction clone
        ao29 init(a3, da, "And")
        fn29 := ScoreModifierAbility clone 
        fn29 init("night")
        c29 setslots("night", ao29, fn29, "nightwizard.png")
        cards append(c29) 

        c30 := Card clone
        fn30 := ScoreModifierAbilitynoble clone
        c30 setslots("noble", a3, fn30, "noblehills.png")
        cards append(c30)

        c31 := Card clone
        ao31 := AndOrAction clone
        ao31 init(a4, da, "And")
        c31 setslots("noble", ao31, ma, "nobleknight.png")
        cards append(c31)   

        c32 := Card clone 
        ao32 := AndOrAction clone
        ao32 init(m4, a1, "And")
        c32 setslots("noble", ao32, ma, "nobleunicorn.png")
        cards append(c32)     

        c33 := Card clone 
        fn33 := ScoreModifierAbility clone 
        fn33 init("dire")
        //Doesn't count itself
        c33 setslots("stronghold", ca, fn33, "stronghold.png")
        cards append(c33)
    )
    init
    shuffle  := method(cards shuffle)
    dealCard := method(cards pop)
    show := method(cards map(card, write(card toString, " \n")); "\n" print)
)