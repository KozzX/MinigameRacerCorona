function new( x,y )
	local sheetData = {
		width=122,
		height=130,
		numFrames=2,
		sheetContentWidth=244,
		sheetContentHeight=130
	}

	local explosaoSheet = graphics.newImageSheet( "images/explosao.png", sheetData )

	local sequenceData = {
		{name = "explosao",
		frames = {1,2},
		time = 250,
		loopCount = 0
		}	
	}

	local explosao = display.newSprite(explosaoSheet, sequenceData)
	explosao.anchorX = 0
	explosao.anchorY = 0
	explosao.x = x
	explosao.y = y
	explosao:play( )

	return explosao

end

function newLoad( x,y )
	local sheetData = {
		width=122,
		height=130,
		numFrames=2,
		sheetContentWidth=244,
		sheetContentHeight=130
	}

	local explosaoSheet = graphics.newImageSheet( "images/explosao.png", sheetData )

	local sequenceData = {
		{name = "explosao",
		frames = {1,2},
		time = 600,
		loopCount = 0
		}	
	}

	local explosao = display.newSprite(explosaoSheet, sequenceData)
	explosao.x = x
	explosao.y = y
	explosao:play( )

	return explosao

end

return{
	new = new,
	newLoad = newLoad
}