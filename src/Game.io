#!/usr/bin/env io

OpenGL; Random;

Object setParent := method(p,
	self parent := p
	self ?appendProto(p)
)

Point := Object clone do(
	x := nil
	y := nil
	init := method(x0,y0,
		self x = x0
		self y = y0
		return self
	)
)

Lobby doFile(Path with(System launchPath, "Player.io"))
Lobby doFile(Path with(System launchPath, "Turn.io"))
Lobby doFile(Path with(System launchPath, "Board.io"))

Player1 := Player clone
Player2 := Player clone
Player3 := Player clone
Player4 := Player clone
Players := list(Player1, Player2, Player3, Player4)

EightMinEm := Object clone do(
	setParent(OpenGL)
	width := 1000
	height := 1000
	//regions := Board regions
	//piece := Point clone init(-0.5,0.5)
	pieceIn := 0
	clickState := 0

)

EightMinEm normalizeX := method(val,
	return (val - (width / 2)) / (width / 2)
)

EightMinEm normalizeY := method(val,
	return ((height / 2) - val) / (height / 2)
)

EightMinEm mouse := method(button, state, x, y,
	if (state == 0 and button == 0,
		for(j, 0, Board regions size - 1,
			p1 :=  (Board regions at(j)) at(0)
			p2 :=  (Board regions at(j)) at(1)
			if (((self normalizeX(x)) >= (p1 x)) and 
				((self normalizeX(x)) < (p2 x)) and
				((self normalizeY(y)) <= (p1 y)) and 
				((self normalizeY(y)) > (p2 y)),
				if (pieceIn == j,
					//then
					self clickState = 1
					return,
					if (self clickState == 1,
						self clickState = 0
						Board piece x = (p1 x) + 0.5
						Board piece y = (p1 y) - 0.5
						self pieceIn = j
						return
					)
				)			
			)
		)
	)
	self display
)

EightMinEm drawGame := method(
	image := Image clone open(
		Path with(System launchPath, "../img/cover.jpg"))

	radius := 0.05
	if (image error, writeln("*** drawPiece: ", image error))
	glPushMatrix
	glTranslated(0, 0, 0)
	image draw
	glPopMatrix

	glPushMatrix
	(Color clone set(1, 0, 0, 1)) glColor
	glTranslated(Board piece x, Board piece y, 0)
	gluDisk(gluNewQuadric, 0, radius, 90, 1)
	glPopMatrix

	glPushMatrix
	glColor4d(1, 0, 1, 1)
	glBegin(GL_LINES)
	glVertex3d(0, 1, 0)
	glVertex3d(0, -1, 0)
	glVertex3d(-1, 0, 0)
	glVertex3d(1, 0, 0)
	glEnd
	glPopMatrix
)

EightMinEm display := method(
	//writeln("display stuff")
	glClear(GL_COLOR_BUFFER_BIT)
	glLoadIdentity

	//draw stuff here
	drawGame
	glFlush
	glutSwapBuffers
)

EightMinEm run := method(
	writeln("run")

	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA)
	glutInitWindowSize(self width, self height)
	glutInitWindowPosition(1000, 60)
	glutInit
	glutCreateWindow("8 Minute Empires: Legends")
	glutEventTarget(self)
	glutDisplayFunc
	//glutKeyboardFunc
	//glutSpecialFunc
	//glutMotionFunc
	glutMouseFunc
	//glutPassiveMotionFunc
	//glutReshapeFunc
	
	glEnable(GL_LINE_SMOOTH)
	glEnable(GL_BLEND)
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
	glBlendFunc(GL_SRC_ALPHA, GL_ONE)
	glHint(GL_LINE_SMOOTH_HINT, GL_NICEST)
	glutMainLoop
)

EightMinEm do(
	writeln("launchPath: ", System launchPath)
	run
)

gameApp run