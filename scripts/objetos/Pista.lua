function new( x,y )
	local sheetData = {
		width=32,
		height=802,
		numFrames=3,
		sheetContentWidth=96,
		sheetContentHeight=802
	}

	local pistaSheet = graphics.newImageSheet( "images/pista.png", sheetData )

	local sequenceData = {
		{name = "pista",
		frames = {1,2,3},
		time = 150,
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