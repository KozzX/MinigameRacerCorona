local widget = require("widget")


function newPlayButton()
	local btn = widget.newButton
	{
	    id = "playBtn",
	    --baseDir = "images/",
	    defaultFile = "images/play.png",
	    overFile = "images/playPressed.png",
	    --onEvent = handleButtonEvent
	}
	btn.width = display.contentWidth / 16 * 5
	btn.height = display.contentHeight / 25 * 3
	btn.x = display.contentCenterX
	btn.anchorY = 0
	btn.y = display.contentHeight / 25 * 15

	return btn
end

return{
	newPlayButton = newPlayButton
}
