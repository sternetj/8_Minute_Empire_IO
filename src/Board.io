#!/usr/bin/env io

// TODO: Render Pieces/Castles/Starting location
// TODO: Regions correspond to regions as pictured

Region := Object clone do(
	init := method (id,px,py,
		self id := id
		self x := px
		self y := py
		self neighbors := List clone
	)
	
	addNeighbor := method(r,
		self neighbors append(r)
	)
	
	isNeighbor := method(r,
		self neighbors contains(r) 
	)

	asString := method(
		self id
	)

	//BFS
	getPath := method(toRegion,
		open := self neighbors clone
		closed := list(self)
		backEdges := open map(n, list(self, n))
		while(open size > 0,
			current := open removeFirst
			if(current == toRegion, return(constructPath(backEdges,self,toRegion)))
			closed append(current)
			current neighbors foreach(n,
				if(closed contains(n) not,
					closed append(n)
					open append(n)
					backEdges append(list(current,n))
				)
			)
		)
		List clone
	)

	constructPath := method(edges,from,to,
		path := list clone
		current := to
		while(current != from,
			path append(current)
			current = edges detect(pair, pair last == current) first
		)
		path reverse 
	) 
)

Board := Object clone do(
	//piece := Point clone init(-0.5,0.5)
	r1 := Region clone
	r1 init("r1",311,977)
	r2 := Region clone
	r2 init("r2",299,903)
	r3 := Region clone
	r3 init("r3",377,837)
	r4 := Region clone
	r4 init("r4",483,877)
	r5 := Region clone
	r5 init("r5",399,702)
	r6 := Region clone
	r6 init("r6",348,659)
	r7 := Region clone
	r7 init("r7",510,634)
	r8 := Region clone
	r8 init("r8",449,568)
	r9 := Region clone
	r9 init("r9",525,525)
	r10 := Region clone
	r10 init("r10",396,497)
	r11 := Region clone
	r11 init("r11",387,426)
	r12 := Region clone
	r12 init("r12",707,678)
	r13 := Region clone
	r13 init("r13",701,567)
	r14 := Region clone
	r14 init("r14",753,451)
	r15 := Region clone
	r15 init("r15",240,402)
	r16 := Region clone
	r16 init("r16",114,441)
	r17 := Region clone
	r17 init("r17",220,506)
	r18 := Region clone
	r18 init("r18",101,543)
	r19 := Region clone
	r19 init("r19",194,607)
	r20 := Region clone
	r20 init("r20",113,651)
	r21 := Region clone
	r21 init("r21",162,685)
	r22 := Region clone
	r22 init("r22",562,942)

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
	r8 addNeighbor(r9)
	r8 addNeighbor(r10)
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
	r17 addNeighbor(r16)
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

writeln("Path between r1 and r2: ", Board r1 getPath(Board r2))
writeln("Path between r1 and r3: ", Board r1 getPath(Board r3))
writeln("Path between r1 and r4: ", Board r1 getPath(Board r4))
writeln("Path between r1 and r5: ", Board r1 getPath(Board r5))
writeln("Path between r1 and r6: ", Board r1 getPath(Board r6))
writeln("Path between r1 and r7: ", Board r1 getPath(Board r7))
writeln("Path between r1 and r8: ", Board r1 getPath(Board r8))
writeln("Path between r1 and r9: ", Board r1 getPath(Board r9))
writeln("Path between r1 and r10: ", Board r1 getPath(Board r10))
writeln("Path between r1 and r11: ", Board r1 getPath(Board r11))
writeln("Path between r1 and r12: ", Board r1 getPath(Board r12))
writeln("Path between r1 and r13: ", Board r1 getPath(Board r13))
writeln("Path between r1 and r14: ", Board r1 getPath(Board r14))
writeln("Path between r1 and r15: ", Board r1 getPath(Board r15))
writeln("Path between r1 and r16: ", Board r1 getPath(Board r16))
writeln("Path between r1 and r17: ", Board r1 getPath(Board r17))
writeln("Path between r1 and r18: ", Board r1 getPath(Board r18))
writeln("Path between r1 and r19: ", Board r1 getPath(Board r19))
writeln("Path between r1 and r20: ", Board r1 getPath(Board r20))
writeln("Path between r1 and r21: ", Board r1 getPath(Board r21))
writeln("Path between r1 and r22: ", Board r1 getPath(Board r22))