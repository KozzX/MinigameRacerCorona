
local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()
local Google = require("scripts.util.Google")

loginGooglePlay()

local transitionOptions = {
	effect = "fade",
    time = 1000
}



local function handleButtonEvent( event )
    if ( "ended" == event.phase ) then
        composer.gotoScene( "scripts.cenas.world", transitionOptions )
    end
end

---------------------------------------------------------------------------------
-- SCENE EVENTS
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:create( event )
	local group = self.view
	
	local bg = display.newImage( "images/background.png", true)
	bg.anchorX, bg.anchorY = 0, 0

	local titleTable = display.newImage( "images/title.png",true )
	--titleTable.anchorX, titleTable.anchorY = 0,0
	titleTable.x = display.contentCenterX
	titleTable.y = display.contentCenterY
	titleTable.width = display.contentWidth / 16 * 12
	titleTable.height = display.contentHeight / 25 * 13




	-- Create the widget
	local btn = widget.newButton
	{
	    id = "playBtn",
	    defaultFile = "images/play.png",
	    overFile = "images/playPressed.png",
	    onEvent = handleButtonEvent
	}
	btn.width = display.contentWidth / 16 * 5
	btn.height = display.contentHeight / 25 * 3
	btn.x = display.contentCenterX
	btn.anchorY = 0
	btn.y = display.contentHeight / 25 * 15

	group:insert( bg )
	group:insert( titleTable )
	group:insert( btn )
	group.alpha = 0
	transition.to( group, {time=1000, alpha =1} )


end


-- Called immediately after scene has moved onscreen:
function scene:show( event )
	local group = self.view


	
end


-- Called when scene is about to move offscreen:
function scene:hide( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroy( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	
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