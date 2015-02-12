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
			Path with(System launchPath, "/img/".. imgName))
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


//TODO: try to keep Game, Board, and OpenGL logic in their seperate files
//TODO: update the game object as input is processed
//TODO: get pictures for starting location and castles
EightMinEm := Object clone do(
	init := method(
		setParent(OpenGL)
		self width := 910
		self height := 1000
		self pieceIn := 0
		self clickState := 0
		//should be in game?
		self gameState := "Start"
		self backgroundImg := ImageWrapper new("cover.png", 331, 500)
		self boardImg := ImageWrapper new("map.png", 905, 709)
		self coinIcon := ImageWrapper new("coinsIco.png", 23, 23)
		self armyIcon := ImageWrapper new("armyIco.png", 18, 18)
		self moveIcon := ImageWrapper new("moveIco.png", 43, 17)
		self flightIcon := ImageWrapper new("flightIco.png", 30, 17)
		self elixirIcon := ImageWrapper new("elixirIco.png", 23, 23)
		self fontSize := 16
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

	//TODO: click updates the market
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

	//TODO: call drawPlayers here with all 4 players
	drawGame := method(
		bkgndColor := Color clone set(0, 0, 0, 1)
		bkgndColor do(
			OpenGL glClearColor(red, green, blue, alpha)
		)

		boardImg drawImage(normalToPointX(0), normalToPointY(0.25))

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
		if (self height < 900,
			self height = 900
		)
	)

	// TODO: Draw the market costs (0,1,1,2,2,3) above/beneath the cards
	// TODO: Why is the first card not drawing?
	drawCards := method(
		bkgndColor := Color clone set(0, 0, 0, 1)
		bkgndColor do(
			OpenGL glClearColor(red, green, blue, alpha)
		)
		for(i,0,5,
			write(i, ": ", Market available at(i), "\n")
			ImageWrapper new(Market available at(i) image, 100, 180) drawImage(normalToPointX(-.95+i*0.38), normalToPointY(-0.78))
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

	// TODO: Parameterize for any given Player
	// TODO: Stack/move cards based on how many
	// TODO: Draw all 4 players states at each edge of the screen, 
	// maybe just use a rotated matrix?
	drawPlayer := method(
		bkgndColor := Color clone set(0, 0, 0, 1)
		bkgndColor do(
			OpenGL glClearColor(red, green, blue, alpha)
		)

		/* setup test drawPlayer */
		cardList := list(Deck dealCard, Deck dealCard, Deck dealCard)
		testPlayer := Player clone
		testPlayer init(14)
		cardList foreach(c, testPlayer cards append(c))
		testPlayer cards foreach(c, c ability affect(testPlayer))
		/**/

		//Draw Cards
		testPlayer cards foreach(i, c,
			ImageWrapper new(c image, 100, 180) drawImage(normalToPointX(-.4 + .4 * i), normalToPointY(-1.15))
		)

		//Draw Modifiers
		glPushMatrix
		glTranslated(865, 105, 0)
		coinIcon drawImage(0,0)
		armyIcon drawImage(3,-23)
		moveIcon drawImage(-10,-43)
		flightIcon drawImage(-3,-63)
		elixirIcon drawImage(0,-88)
		glPopMatrix

		glPushMatrix
		glColor4d(0, 1, 0, 1)
		glTranslated(880, 100, 0)
		drawString(testPlayer coins asString)
		glPopMatrix

		glPushMatrix
		glColor4d(1, 0, 0, 1)
		glTranslated(880, 80, 0)
		drawString("+" .. testPlayer armyMod asString)
		glPopMatrix

		glPushMatrix
		glColor4d(1, 0, 1, 1)
		glTranslated(880, 57, 0)
		drawString("+" ..  testPlayer moveMod asString)
		glPopMatrix

		glPushMatrix
		glColor4d(1, 1, 0, 1)
		glTranslated(880, 37, 0)
		drawString(testPlayer flyingMod asString)
		glPopMatrix

		glPushMatrix
		glColor4d(0, 1, 1, 1)
		glTranslated(880, 12, 0)
		drawString(testPlayer elixirs asString)
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
		if(self gameState == "Start") then(drawBackground) elseif(self gameState =="Play") then(drawGame; drawCards) else(drawPlayer)
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
        	if(key asCharacter == "5",
        		self gameState = "Player"
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