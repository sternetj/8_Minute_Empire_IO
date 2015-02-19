#!/usr/bin/env io

Region := Object clone do(
	init := method (id,px,py,cont,
		self id := id
		self x := px
		self y := py
		self continent := cont
		self neighbors := List clone
		self armies := list(0, 0, 0, 0)
		self castles := list(0, 0, 0, 0)
	)

	addcastle := method(playnum,
	castles atPut(playnum, castles at(playnum) + 1))

	addarmy := method(playnum,
	armies atPut(playnum, armies at(playnum) + 1))

	addNeighbor := method(r,isWaterConnection,
		self neighbors append(list(r,isWaterConnection))
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
			cRegion := current at(0)
			if(cRegion == toRegion, return(constructPath(backEdges,self,cRegion)))
			closed append(current)
			cRegion neighbors foreach(n,
				if(closed contains(n) not,
					closed append(n)
					open append(n)
					backEdges append(list(cRegion,n))
				)
			)
		)
		List clone
	)

	constructPath := method(edges,from,to,
		path := list clone
		current := to
		while(current != from,
			edge := edges detect(pair, pair last first == current)
			path append(edge last)
			current = edge first
		)
		path reverse 
	) 
)

Board := Object clone do(
	r1 := Region clone
	r1 init("r1",311,47,"N")
	r2 := Region clone
	r2 init("r2",299,121,"N")
	r3 := Region clone
	r3 init("r3",377,187,"N")
	r4 := Region clone
	r4 init("r4",483,147,"N")
	r5 := Region clone
	r5 init("r5",399,322,"S")
	r6 := Region clone
	r6 init("r6",348,365,"S")
	r7 := Region clone
	r7 init("r7",510,390,"S")
	r8 := Region clone
	r8 init("r8",449,456,"S")
	r9 := Region clone
	r9 init("r9",525,499,"S")
	r10 := Region clone
	r10 init("r10",396,527,"S")
	r11 := Region clone
	r11 init("r11",387,598,"S")
	r12 := Region clone
	r12 init("r12",707,346,"E")
	r13 := Region clone
	r13 init("r13",701,457,"E")
	r14 := Region clone
	r14 init("r14",753,573,"E")
	r15 := Region clone
	r15 init("r15",240,622,"W")
	r16 := Region clone
	r16 init("r16",114,583,"W")
	r17 := Region clone
	r17 init("r17",220,518,"W")
	r18 := Region clone
	r18 init("r18",101,481,"W")
	r19 := Region clone
	r19 init("r19",194,417,"W")
	r20 := Region clone
	r20 init("r20",113,373,"W")
	r21 := Region clone
	r21 init("r21",162,339,"W")
	r22 := Region clone
	r22 init("r22",562,82,"N")

	r1 addNeighbor(r2,false)
	r1 addNeighbor(r4,true)
	r2 addNeighbor(r1,false)
	r2 addNeighbor(r3,false)
	r3 addNeighbor(r2,false)
	r3 addNeighbor(r4,false)
	r3 addNeighbor(r5,true)
	r4 addNeighbor(r1,true)
	r4 addNeighbor(r3,false)
	r4 addNeighbor(r22,false)
	r5 addNeighbor(r3,true)
	r5 addNeighbor(r6,false)
	r6 addNeighbor(r5,false)
	r6 addNeighbor(r8,true)
	r7 addNeighbor(r8,false)
	r8 addNeighbor(r6,true)
	r8 addNeighbor(r7,false)
	r8 addNeighbor(r9,false)
	r8 addNeighbor(r10,false)
	r9 addNeighbor(r7,false)
	r9 addNeighbor(r8,false)
	r9 addNeighbor(r13,true)
	r10 addNeighbor(r17,true)
	r10 addNeighbor(r8,false)
	r10 addNeighbor(r11,false)
	r11 addNeighbor(r10,false)
	r12 addNeighbor(r13,false)
	r13 addNeighbor(r12,false)
	r13 addNeighbor(r9,true)
	r13 addNeighbor(r14,false)
	r14 addNeighbor(r13,false)
	r15 addNeighbor(r16,false)
	r15 addNeighbor(r17,false)
	r16 addNeighbor(r15,false)
	r16 addNeighbor(r17,false)
	r16 addNeighbor(r18,false)
	r17 addNeighbor(r15,false)
	r17 addNeighbor(r16,false)
	r17 addNeighbor(r18,false)
	r17 addNeighbor(r19,false)
	r17 addNeighbor(r10,true)
	r18 addNeighbor(r17,false)
	r18 addNeighbor(r16,false)
	r18 addNeighbor(r19,false)
	r19 addNeighbor(r20,false)
	r19 addNeighbor(r17,false)
	r19 addNeighbor(r16,false)
	r19 addNeighbor(r21,false)
	r19 addNeighbor(r20,false)
	r20 addNeighbor(r21,false)
	r20 addNeighbor(r19,false)
	r21 addNeighbor(r20,false)
	r21 addNeighbor(r19,false)
	r22 addNeighbor(r4,false)

	regions := list(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22)
)

// writeln("Path between r1 and r2: ", Board r1 getPath(Board r2)) 	
// writeln("Path between r1 and r3: ", Board r1 getPath(Board r3)) 	
writeln("Path between r1 and r4: ", Board r1 getPath(Board r4)) 	
writeln("Path between r1 and r5: ", Board r1 getPath(Board r5)) 	
//writeln("Path between r1 and r6: ", Board r1 getPath(Board r6)) 	
//writeln("Path between r1 and r7: ", Board r1 getPath(Board r7)) 	
writeln("Path between r1 and r8: ", Board r1 getPath(Board r8)) 	
//writeln("Path between r1 and r9: ", Board r1 getPath(Board r9)) 	
//writeln("Path between r1 and r10: ", Board r1 getPath(Board r10)) 	
//writeln("Path between r1 and r11: ", Board r1 getPath(Board r11)) 	
//writeln("Path between r1 and r12: ", Board r1 getPath(Board r12)) 	
writeln("Path between r1 and r13: ", Board r1 getPath(Board r13)) 	
//writeln("Path between r1 and r14: ", Board r1 getPath(Board r14)) 	
//writeln("Path between r1 and r15: ", Board r1 getPath(Board r15)) 	
//writeln("Path between r1 and r16: ", Board r1 getPath(Board r16)) 	
writeln("Path between r1 and r17: ", Board r1 getPath(Board r17)) 	
// writeln("Path between r1 and r18: ", Board r1 getPath(Board r18)) 	
// writeln("Path between r1 and r19: ", Board r1 getPath(Board r19)) 	
// writeln("Path between r1 and r20: ", Board r1 getPath(Board r20)) 	
// writeln("Path between r1 and r21: ", Board r1 getPath(Board r21)) 	
// writeln("Path between r1 and r22: ", Board r1 getPath(Board r22))
