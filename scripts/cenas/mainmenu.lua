local composer = require( "composer" )
local scene = composer.newScene()
local Botao = require( "scripts.objetos.Botao" )

local bg
local titleTable
local btn

local transitionOptions = {
	effect = "fade",
    time = 1000
}


local function handleButtonEvent( event )
    if ( "ended" == event.phase ) then
        composer.gotoScene( "scripts.cenas.level1", transitionOptions )
    end
end

---------------------------------------------------------------------------------
-- SCENE EVENTS
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:create( event )
	local group = self.view
	
end


-- Called immediately after scene has moved onscreen:
function scene:show( event )
	local group = self.view

	if event.phase == "will" then

	elseif event.phase == "did" then
		bg = display.newImage( "images/background.png", true)
		bg.anchorX, bg.anchorY = 0, 0

		titleTable = display.newImage( "images/title.png",true )
		titleTable.x = display.contentCenterX
		titleTable.y = display.contentCenterY
		titleTable.width = display.contentWidth / 16 * 12
		titleTable.height = display.contentHeight / 25 * 13

		btn = Botao.newPlayButton()
		btn:addEventListener( "touch", handleButtonEvent )
		transition.to( btn, {time = 1000, alpha = 1} )
	
		group:insert( bg )
		group:insert( titleTable )
		group:insert( btn )
		group.alpha = 0
		transition.to( group, {time=1000, alpha =1} )
	end 


	
end


-- Called when scene is about to move offscreen:
function scene:hide( event )
	local group = self.view
	btn:removeEventListener( "touch", handleButtonEvent )
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroy( event )
	local group = self.view
	
end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene