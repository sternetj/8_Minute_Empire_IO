#!/usr/bin/env io

// TODO: Render Pieces/Castles/Starting location
// TODO: Regions correspond to regions as pictured

Region := Object clone do(
	x := nil
	y := nil
	neighbors := List clone
	new := method (px,py,
			self x = px
			self y = py
		)
	addNeighbor := method(region,
			neighbors append(region)
		)
	isNeighbor := method(region, val := false; self neighbors foreach(i, v, if (v == region, val := true)); val)
)

Board := Object clone do(
	piece := Point clone init(-0.5,0.5)
	r1 := Region clone
	r1 new(311,977)

	r2 := Region clone
	r2 new(299,903)

	r3 := Region clone
	r3 new(377,837)


	r4 := Region clone
	r4 new(483,877)
	r5 := Region clone
	r5 new(399,702)
	r6 := Region clone
	r6 new(348,659)
	r7 := Region clone
	r7 new(510,634)
	r8 := Region clone
	r8 new(449,568)
	r9 := Region clone
	r9 new(525,525)
	r10 := Region clone
	r10 new(396,497)
	r11 := Region clone
	r11 new(387,426)
	r12 := Region clone
	r12 new(707,678)
	r13 := Region clone
	r13 new(701,567)
	r14 := Region clone
	r14 new(753,451)
	r15 := Region clone
	r15 new(240,402)
	r16 := Region clone
	r16 new(114,441)
	r17 := Region clone
	r17 new(220,506)
	r18 := Region clone
	r18 new(101,543)
	r19 := Region clone
	r19 new(194,607)
	r20 := Region clone
	r20 new(113,651)
	r21 := Region clone
	r21 new(162,685)
	r22 := Region clone
	r22 new(562,942)

	r1 addNeighbor(r2)
	r1 addNeighbor(r4)
	r2 addNeighbor(r1)
	r2 addNeighbor(r3)
	r3 addNeighbor(r2)
	r3 addNeighbor(r4)
	r3 addNeighbor(r5)
	r4 addNeighbor(r1)
	r4 addNeighbor(r3)
	r4 addNeighbor(r22)
	r5 addNeighbor(r3)
	r5 addNeighbor(r6)
	r6 addNeighbor(r5)
	r6 addNeighbor(r8)
	r7 addNeighbor(r8)
	r8 addNeighbor(r6)
	r8 addNeighbor(r7)
	r9 addNeighbor(r7)
	r9 addNeighbor(r8)
	r9 addNeighbor(r13)
	r10 addNeighbor(r17)
	r10 addNeighbor(r8)
	r10 addNeighbor(r11)
	r11 addNeighbor(r10)
	r12 addNeighbor(r13)
	r13 addNeighbor(r12)
	r13 addNeighbor(r9)
	r13 addNeighbor(r14)
	r14 addNeighbor(r13)
	r15 addNeighbor(r16)
	r15 addNeighbor(r17)
	r16 addNeighbor(r15)
	r16 addNeighbor(r17)
	r16 addNeighbor(r18)
	r17 addNeighbor(r15)
	r17 addNeighbor(r18)
	r17 addNeighbor(r19)
	r17 addNeighbor(r10)
	r18 addNeighbor(r17)
	r18 addNeighbor(r16)
	r18 addNeighbor(r19)
	r19 addNeighbor(r20)
	r19 addNeighbor(r17)
	r19 addNeighbor(r16)
	r19 addNeighbor(r21)
	r19 addNeighbor(r20)
	r20 addNeighbor(r21)
	r20 addNeighbor(r19)
	r21 addNeighbor(r20)
	r21 addNeighbor(r19)
	r22 addNeighbor(r4)
	regions := list(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22)
)