local storyboard = require( "storyboard" )
local widget = require( "widget" )
local scene = storyboard.newScene()
local Carro = require( "Carro" )
local Obstaculo = require( "Obstaculo" )
local physics = require( "physics" )
local Explosao = require("Explosao")

physics.start( )
physics.setGravity( 0, 0 )

---------------------------------------------------------------------------------
-- SCENE EVENTS
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view


	background = display.newImage( "img/background.png", true);
	background.anchorX, background.anchorY = 0,0


	local carro = Carro.new(5,19)

	local textPontos = 
	{
	    text = 0,     
	    x = display.contentCenterX,
	    y = display.contentCenterY/25 * 2,
	    font = native.systemFont,   
	    fontSize = 50 
	}

	local pontos = display.newText( textPontos )
	pontos:setFillColor( 0/255, 0/255, 0/255 )

	transition.to( background, {time=0,alpha=0} )
	transition.to( carro, {time=0,alpha=0} )

	
	
	local function carregarCena( event )
    	transition.to( background, {time=500,alpha=1} )
    	transition.to( carro, {time=500,alpha=1} )
	end
	timer.performWithDelay( 1500, carregarCena )
	
	function carregarObstaculo( event )
		local obstaculo = Obstaculo.new(math.random(-1,14))
		local obstaculo = Obstaculo.new(math.random(-1,14))
	end
	timer1 = timer.performWithDelay( 1000, carregarObstaculo, -1 )

	function enterFrameListener( event )
		pontos.text = pontos.text + (0.016);
	end
	
	
	


	local function onCollision( event )
		if event.phase == "began" then
       		local agro = event.object1
       		local hit = event.object2
 
        	if agro.type == "carro" and hit.type == "obstaculo" then
				timer.cancel( timer1 )
				Runtime:removeEventListener( "enterFrame", enterFrameListener )
				local explosao = Explosao.new(carro.x, carro.y)
				carro:removeSelf( )
				transition.pause( obstaculo )
        	end
    	end
	end
	Runtime:addEventListener( "collision", onCollision )

	


end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------
	Runtime:addEventListener("enterFrame",enterFrameListener)
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