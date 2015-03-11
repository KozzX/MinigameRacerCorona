function new()
	local background = display.newImage( "images/background.png", true);
	background.anchorX, background.anchorY = 0,0
	background.width = display.contentWidth
	background.height = display.contentHeight

	return background
end

return{
	new = new
}