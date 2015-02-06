#!/usr/bin/env io

Board := Object clone do(
	regions := list(list(Point clone init(-1,1),Point clone init(0,0)),
					list(Point clone init(0,1),Point clone init(1,0)),
					list(Point clone init(-1,0),Point clone init(0,-1)),
					list(Point clone init(0,0),Point clone init(1,-1)))
	piece := Point clone init(-0.5,0.5)
)