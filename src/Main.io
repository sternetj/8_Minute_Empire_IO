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
EightMinEm := Object clone do(
	init := method(
		setParent(OpenGL)
		self width := 1600
		self height := 1000
		self pieceIn := 0
		self clickState := 0
		self inGame := false
		self backgroundImg := ImageWrapper new("cover.png", 331, 500)
		self boardImg := ImageWrapper new("map.png", 905, 709)
		self coinIcon := ImageWrapper new("coinsIco.png", 23, 23)
		self armyIcon := ImageWrapper new("armyIco.png", 18, 18)
		self moveIcon := ImageWrapper new("moveIco.png", 43, 17)
		self flightIcon := ImageWrapper new("flightIco.png", 30, 17)
		self elixirIcon := ImageWrapper new("elixirIco.png", 23, 23)
		self gMarker := ImageWrapper new("green.png", 28, 24)	
		self bMarker := ImageWrapper new("blue.png", 28, 24)	
		self rMarker := ImageWrapper new("red.png", 28, 24)	
		self cMarker := ImageWrapper new("cyan.png", 28, 24)
		self armyimg := list(gMarker,bMarker,rMarker,cMarker)
		self castle := ImageWrapper new("casorg.png", 42, 42)
		self bcMarker := ImageWrapper new("casbluesmall.png", 42, 42)	
		self gcMarker := ImageWrapper new("casgreensmall.png", 42, 42)	
		self rcMarker := ImageWrapper new("casmagsmall.png", 42, 42)
		self ccMarker := ImageWrapper new("cascyansmall.png", 42, 44)
		self casimg := list(gcMarker, bcMarker,rcMarker, ccMarker)
		self fontSize := 16
		self mouseX := 0
		self mouseY := 0
		self fromRegion := nil
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

	mouse := method(button, state, mx, my,
		self mouseX = mx
		self mouseY = height - my
		if (inGame and state == 0 and button == 0,
			writeln("(",mx,",",self height - my,")")
			self clickState = 1
			if (Game gameState == "Buy") then (
				for(j, 0, Market locations size - 1,
					px :=  (Market locations at(j)) x + 50
					py :=  (Market locations at(j)) y - 90
					if(((px - mx) abs < 100) and ((py - (self height - my)) abs < 180),
						Game activeTurn takeTurn(j)
					)
				)
			) elseif (Game gameState == "Army") then (
				false
			) elseif (Game gameState == "Move") then (
				for(j, 0, Board regions size - 1,
					px :=  (Board regions at(j)) x
					py :=  (Board regions at(j)) y
					if(((px - mx) abs < 35) and ((py - my) abs < 35),
						self fromRegion = j
						writeln("In region ", j + 1)
						if (Board regions at(j) armies at(Game activePlayer) == 0,
							self clickState = 0
							glPushMatrix
							glTranslated(1100,80,0)
							glColor4d(1,1,1,1)
							drawString("You have no armies in this region.")
							glPopMatrix
							
						)
					)
				)
			) elseif (Game gameState == "Destroy") then (
				false
			) elseif (Game gameState == "City") then (
				Game activePlayer
			) else (

			)
			,
			self clickState = 0
			if (Game gameState == "Buy") then (
				false
			) elseif (Game gameState == "Army") then (
				false
			) elseif (Game gameState == "Move") then (
				for(j, 0, Board regions size - 1,
					px :=  (Board regions at(j)) x
					py :=  (Board regions at(j)) y
					if(((px - mx) abs < 35) and ((py - my) abs < 35),
						Game activeTurn takeTurn(list(fromRegion, j))
					)
				)

			) elseif (Game gameState == "Destroy") then (
				false
			) elseif (Game gameState == "City") then (
				Game activePlayer
			) else (
				false
			)
		)	
		display
	)

	//Only called when mouse is down
	motion := method(x, y,
		self mouseX = x
		self mouseY = height - y
	)

	//TODO: call drawPlayers here with all 4 players
	drawGame := method(
		bkgndColor := Color clone set(0, 0, 0, 1)
		bkgndColor do(
			OpenGL glClearColor(red, green, blue, alpha)
		)

		boardImg drawImage(boardImg width / 2, (self height) - (boardImg height / 2))

		Game players foreach(i,p, drawPlayer(i,p))
		
		for(j, 0, Board regions size - 1,
			radius := 10
			xcom := Board regions at(j) x
			ycom := height - (Board regions at(j) y)
			(Color clone set(1, 1, 1, 1)) glColor
			if(j == Game startingRegion, castle drawImage(Board regions at(j) x, height - (Board regions at(j) y)))
			Board regions at(j) armies foreach( i, v, 
				if(v > 0, 
					glPushMatrix
					glTranslated(xcom + 30 * (3.141*i/4) cos, ycom + 30 * (3.141*i/4) sin, 0)
					armyimg at(i) drawImage()
					(Color clone set(0, 0, 0, 1)) glColor
					self fontSize = fontSize + 4
					drawString(v asString)
					(Color clone set(1, 1, 1, 1)) glColor
					self fontSize = fontSize - 4
					drawString(v asString)
					glPopMatrix
				)
			)
			numcas := Board regions at(j) castles select(>0) size
			inc := 0
			Board regions at(j) castles foreach( i, v, 
				if(v > 0, 
					glPushMatrix;
					glTranslated(xcom + 30 * (-3.141*(inc+1)/numcas) cos, ycom + 30 * (-3.141*(inc+1)/numcas) sin, 0)
					casimg at(i) drawImage()
					glPopMatrix
					inc := inc + 1
				)
			)
		)
		glPushMatrix
		glTranslated(1100,100,0)
		glColor4d(1,1,1,1)
		drawString(Game message)
		glPopMatrix
	)
	
	drawMarket := method(
		bkgndColor := Color clone set(0, 0, 0, 1)
		bkgndColor do(
			OpenGL glClearColor(red, green, blue, alpha)
		)
		for(i,0,5,
			img := ImageWrapper new(Market available at(i) image, 100, 180) 
			x := img width / 2 + i * 170
			y := img height / 2 + 30
			img drawImage(x,y)
			glPushMatrix
			glTranslated(x + 20,10,0)
			glColor4d(0,1,0,1)
			drawString(Market costs at(i) asString)
			glPopMatrix
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

	drawRegions := method(
		castle := ImageWrapper new("casorg.png", 42, 42)
		for(j, 0, Board regions size - 1,
			radius := 10
			xcom := Board regions at(j) x
			ycom := height - (Board regions at(j) y)
			(Color clone set(1, 1, 1, 1)) glColor
			Board regions at(j) armies foreach( i, v, if (v>0, 
				glPushMatrix;
				glTranslated(xcom + 30 * (3.141*i/4) cos ,
				 ycom + 30 * (3.141*i/4) sin, 0);
				armyimg at(i) drawImage(); 
				(Color clone set(0, 0, 0, 1)) glColor
				self fontSize = fontSize +4
				drawString(v asString);
				(Color clone set(1, 1, 1, 1)) glColor
				self fontSize = fontSize -4
				drawString(v asString);
				glPopMatrix
				))
			numcas := Board regions at(j) castles select(>0) size
			inc := 0
			Board regions at(j) castles foreach( i, v, if (v>0, 
				glPushMatrix;
				glTranslated(xcom + 30 * (-3.141*(inc+1)/numcas) cos ,
				 ycom + 30 * (-3.141*(inc+1)/numcas) sin, 0);
				casimg at(i) drawImage(); 
				glPopMatrix;
				inc := inc + 1
				))
			glPushMatrix
			if(j == Game startingRegion, castle drawImage(Board regions at(j) x, height - (Board regions at(j) y)))
			(Color clone set(0.2, 0.2, 0.2, 0.7)) glColor
			glTranslated(xcom, ycom, 0)
			gluDisk(gluNewQuadric, 0, radius, 90, 1)
			glColor4d(0,1,0,1)
			drawString(Board regions at(j) id)
			glPopMatrix	
		)
		// for(j, 0, Market locations size -1,
		// 	glPushMatrix
		// 	(Color clone set(0.2, 0.2, 0.2, 0.7)) glColor
		// 	glTranslated(Market locations at(j) x, Market locations at(j) y, 0)
		// 	glRectd(0, 65, 160, -180)
		// 	glTranslated(70, -70, 0)
		// 	glColor4d(0,1,0,1)
		// 	drawString(Market locations at(j) id)
		// 	glPopMatrix
		// )
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

	// TODO: Stack/move cards based on how many
	drawPlayer := method(idx,player,
		bkgndColor := Color clone set(0, 0, 0, 1)
		bkgndColor do(
			OpenGL glClearColor(red, green, blue, alpha)
		)

		//Draw Modifiers
		glPushMatrix
		glTranslated(self width - 50, (self height - 20) - (255 * idx), 0)
		coinIcon drawImage(0,0)
		armyIcon drawImage(3,-23)
		moveIcon drawImage(-10,-43)
		flightIcon drawImage(-3,-63)
		elixirIcon drawImage(0,-88)
		glColor4d(player color red, player color green, player color blue, player color alpha)
		glTranslated(15,-5,0)
		drawString(player coins asString)
		glTranslated(0, -20, 0)
		drawString("+" .. player armyMod asString)
		glTranslated(0, -21, 0)
		drawString("+" .. player moveMod asString)
		glTranslated(0, -22, 0)
		drawString(player flyingMod asString)
		glTranslated(0, -24, 0)
		drawString(player elixirs asString)

		//Draw Cards
		//player cards foreach(i, c,
			//ImageWrapper new(c image, 100,180) drawImage(-200 - (i * 20), -50)
		//)

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
		//display
	)

	display := method(
		glClear(GL_COLOR_BUFFER_BIT)
		glLoadIdentity

		//draw stuff here
		if(inGame not, drawBackground, drawGame; drawMarket)

		if(inGame and (Game gameState == "Army" or Game gameState == "Move"),
			drawRegions
		)

		if(self clickState == 1 and inGame and (Game gameState == "Army" or Game gameState == "Move"),
			Game players at(Game activePlayer) icon drawImage(mouseX,mouseY)
		)

		

		glFlush
		glutSwapBuffers
	)

	keyboard := method(key, x, y,
		if (inGame not,
			if(key asCharacter == "2", 
				Game newGame(2)
				inGame = true
			)
        	if(key asCharacter == "3", 
        		Game newGame(3)
        		inGame = true
        	)
        	if(key asCharacter == "4", 
        		Game newGame(4)
        		inGame = true
        	)
        	display
		)
    )

    timer := method(v,
		glutTimerFunc(35, 0)
		display
	)

	run := method(
		//writeln("run")
		glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA)
		glutInitWindowSize(self width, self height)
		glutInitWindowPosition(10, 0)
		glutInit
		glutCreateWindow("8 Minute Empires: Legends")
		glutEventTarget(self)
		glutDisplayFunc
		glutKeyboardFunc
		//glutSpecialFunc
		glutMotionFunc
		glutMouseFunc
		//glutPassiveMotionFunc
		glutReshapeFunc
		glutTimerFunc(35, 0)
	
		glEnable(GL_LINE_SMOOTH)
		glEnable(GL_BLEND)
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
		//glBlendFunc(GL_SRC_ALPHA, GL_ONE)
		//glHint(GL_LINE_SMOOTH_HINT, GL_NICEST)
		glutReshapeWindow(self width, self height)
		glutMainLoop
	)
)

EightMinEm do(
	Game init()
	run
)