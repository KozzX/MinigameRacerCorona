function new()
	background = display.newImage( "images/background.png", true);
	background.anchorX, background.anchorY = 0,0
	background.width = display.contentWidth
	background.height = display.contentHeight
end

return{
	new = new
}