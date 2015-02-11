#!/usr/bin/env io
# The main render loop -- run from here

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

Lobby doFile(Path with(System launchPath, "Game.io"))

//only draws PNG files
ImageWrapper := Object clone do(
	setParent(OpenGL)
	image := nil
	width := nil
	height := nil

	new := method(imgName, xDimension, yDimension,
		newIw := self clone
		newIw width := xDimension
		newIw height := yDimension
		e := try (
			newIw image = Image clone open(
			Path with(System launchPath, "/img/".. imgName ..".png"))
		)
		e catch (Exception, if (false, writeln("*** imageWrapper new: ", e error)))
		return newIw
	)

	drawImage := method(x, y,
		if (image) then (
			if (image error, writeln("*** drawPiece: ", image error))
			glPushMatrix
			glTranslated(x - width/2, y - height/2, 0)
			image draw
			glPopMatrix
		) else (
			//self pieceColor glColor
			gluDisk(gluNewQuadric, 0, 0, 90, 1)
			//self pieceColor2 glColor		// darker outline
			gluDisk(gluNewQuadric, 0, 0, 90, 1)
		)
	)
)

EightMinEm := Object clone do(
	init := method(
		setParent(OpenGL)
		self width := 910
		self height := 710
		self pieceIn := 0
		self clickState := 0
		self gameState := "Start"
		self backgroundImg := ImageWrapper new("cover", 331, 500)
		self boardImg := ImageWrapper new("map", 905, 709)
		self fontSize := 16
		self gameObj := nil
	)

	init

	normalizeX := method(val,
		return (val - (width / 2)) / (width / 2)
	)

	normalizeY := method(val,
		return ((height / 2) - val) / (height / 2)
	)

	normalToPointX := method(val,
		return ((val + 1) * (width / 2))
	)

	normalToPointY := method(val,
		return ((val + 1) * (height / 2))
	)

	mouse := method(button, state, x, y,
		if (state == 0 and button == 0,
			//self gameState = "State"
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
		display
	)

	drawGame := method(
		bkgndColor := Color clone set(0, 0, 0, 1)
		bkgndColor do(
			OpenGL glClearColor(red, green, blue, alpha)
		)

		boardImg drawImage(normalToPointX(0), normalToPointY(0))

		// radius := 0.05
		// glPushMatrix
		// (Color clone set(1, 0, 0, 1)) glColor
		// glTranslated(Board piece x, Board piece y, 0)
		// gluDisk(gluNewQuadric, 0, radius, 90, 1)
		// glPopMatrix

		// glPushMatrix
		// glColor4d(1, 0, 1, 1)
		// glBegin(GL_LINES)
		// glVertex3d(0, 1, 0)
		// glVertex3d(0, -1, 0)
		// glVertex3d(-1, 0, 0)
		// glVertex3d(1, 0, 0)
		// glEnd
		// glPopMatrix

		if (self width < 905,
			self width = 905
		)
		if (self height < 709,
			self height = 709
		)
	)

	drawString := method(string,
		if (self ?font) then (
			self font drawString(string)
		) else (
			glPushMatrix
			glScaled(0.14, 0.1, 0)
			glutStrokeString(0, string)
			glPopMatrix
		)
	)

	drawBackground := method(
		bkgndColor := Color clone set(0, 0, 0, 1)
		bkgndColor do(
			OpenGL glClearColor(red, green, blue, alpha)
		)
		
		backgroundImg drawImage(normalToPointX(0), normalToPointY(0))

		glPushMatrix
		glColor4d(0, 1, 0, 1)
		glTranslated(5, 10+fontSize, 0)
		drawString("Welcome to 8 Minute Empires!")
		glPopMatrix
		glPushMatrix
		glTranslated(5, 8, 0)
		drawString("Select the number of players (2-4) to start a new game...")
		glPopMatrix

	)

	reshape := method(w, h, 
		self width = w
		self height = h
		glViewport(0, 0, w, h)
		glMatrixMode(GL_PROJECTION)
		glLoadIdentity
		gluOrtho2D(0, w, 0, h)

		glMatrixMode(GL_MODELVIEW)
		glLoadIdentity
		drawBackground
		display
	)

	display := method(
		//writeln("display stuff")
		glClear(GL_COLOR_BUFFER_BIT)
		glLoadIdentity
		//draw stuff here
		if(self gameState == "Start", drawBackground, drawGame)
		glFlush
		glutSwapBuffers
	)

	keyboard := method(key, x, y,
		if (self gameState == "Start",
			//self gameObj = Game clone
			if(key asCharacter == "2", 
				self gameState = "Play" 
				//self gameObj init(list(Player1, Player2),Board clone)
			)
        	if(key asCharacter == "3", 
        		self gameState = "Play"
        		//self gameObj init(list(Player1, Player2, Player3),Board clone)
        	)
        	if(key asCharacter == "4", 
        		self gameState = "Play"
        		//self gameObj init(list(Player1, Player2, Player3, Player4),Board clone)
        	)
        	display
		)
    )

	run := method(
		//writeln("run")
		glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA)
		glutInitWindowSize(self width, self height)
		glutInitWindowPosition(850, 60)
		glutInit
		glutCreateWindow("8 Minute Empires: Legends")
		glutEventTarget(self)
		glutDisplayFunc
		glutKeyboardFunc
		//glutSpecialFunc
		//glutMotionFunc
		glutMouseFunc
		//glutPassiveMotionFunc
		glutReshapeFunc
	
		glEnable(GL_LINE_SMOOTH)
		glEnable(GL_BLEND)
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
		glBlendFunc(GL_SRC_ALPHA, GL_ONE)
		glHint(GL_LINE_SMOOTH_HINT, GL_NICEST)
		glutReshapeWindow(self width, self height)
		glutMainLoop
	)
)

EightMinEm do(
	//writeln("launchPath: ", System launchPath)
	run
)