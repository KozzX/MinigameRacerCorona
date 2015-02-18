
local storyboard = require( "storyboard" )
local widget = require( "widget" )
local scene = storyboard.newScene()


local transitionOptions = {
	effect = "fade",
    time = 1000
}

local function handleButtonEvent( event )
    if ( "ended" == event.phase ) then
        storyboard.gotoScene( "world", transitionOptions )
    end
end

---------------------------------------------------------------------------------
-- SCENE EVENTS
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	-----------------------------------------------------------------------------
	
	local bg = display.newImage( "img/background.png", true)
	bg.anchorX, bg.anchorY = 0, 0

	local textOptions = 
	{
	    text = "Minigame Racer",     
	    x = display.contentCenterX,
	    y = display.contentCenterY/2,
	    font = native.systemFont,   
	    fontSize = 50 
	}

	local title = display.newText( textOptions )
	title:setFillColor( 0/255, 0/255, 0/255 )

	-- Create the widget
	local btn = widget.newButton
	{
	    x = display.contentCenterX,
	    y = display.contentCenterY,
	    id = "playBtn",
	    label = "Play",
	    fontSize = 50,
	    widget = 100,
	    height = 100,
	    labelColor = { default={ 0, 0, 0 }, over={ 1, 1, 1, 0.5 } },
	    onEvent = handleButtonEvent
	}

	group:insert( bg )
	group:insert( title )
	group:insert( btn )

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	
end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene