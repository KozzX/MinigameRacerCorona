local widget = require("widget")
local Posicionamento = require( "scripts.util.posicionamento" )


function newPlayButton(texto,y)
	local options = {
		id="playBtn",
		x=display.contentWidth,
		y=y,
		width=display.contentWidth / 16 * 10,
		height=display.contentHeight / 25 * 2,
		label=texto,
		labelColor = { default={0,0,0}, over={0,0,0} },
		emboss=true,
		fontSize=40,
		labelAlign="center",
		font="Bitwise",
		shape="roundedRect",
		cornerRadius=10,
		fillColor = { default={0.5,0.5,0.5}, over={0.3,0.3,0.3} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3
	}
	local btn = widget.newButton(options)
	btn.anchorY = 0
	btn.alpha = 0
	--transition.moveTo( btn, {x=display.contentCenterX,time=300} )
	transition.to( btn, {x=display.contentCenterX,alpha=1, time=400} )
	
	
	return btn
end

return{
	newPlayButton = newPlayButton
}
