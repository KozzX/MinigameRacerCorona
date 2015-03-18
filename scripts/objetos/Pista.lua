function new( x,y )
	local sheetData = {
		width=32,
		height=802,
		numFrames=4,
		sheetContentWidth=128,
		sheetContentHeight=802
	}

	local pistaSheet = graphics.newImageSheet( "images/pista.png", sheetData )

	local sequenceData = {
		{name = "pista",
		frames = {1,2,3,4},
		time = 130,
		loopCount = 0
		}	
	}

	local pista = display.newSprite(pistaSheet, sequenceData)
	pista.anchorX = 0
	pista.anchorY = 0
	pista.x = x
	pista.y = y
	pista:play( )

	return pista

end

return{
	new = new
}