local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()
local physics = require( "physics" )
local Explosao = require("scripts.objetos.Explosao")
local Pontos = require( "scripts.objetos.PontosHUD" )
local Carro = require( "scripts.objetos.Carro" )
local Background = require ("scripts.objetos.Background")
--local Obstaculo = require( "scripts.objetos.Obstaculo" )

physics.start( )
physics.setGravity( 0, 0 )


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

		local bg = Background.new()
		local carro = Carro.newCarro(5,19)
		local pontos = Pontos.new()
	
		function carregarObstaculo( event )
			local obstaculo = Carro.newObstaculo(math.random(-1,14))
			local obstaculo = Carro.newObstaculo(math.random(-1,14))
		end
		timerObstaculo = timer.performWithDelay( 1000, carregarObstaculo, -1 )


--------------------------------------------------------------------------------
----------------Detecta colisão entre carro e obstaculo-------------------------
--------------------------------------------------------------------------------
		local function onCollision( event )
			if event.phase == "began" then
       			local agro = event.object1
       			local hit = event.object2
	 
        		if agro.type == "carro" and hit.type == "obstaculo" then
					timer.cancel( timerObstaculo )
					Runtime:removeEventListener( "enterFrame", enterFrameListener )
					pontos:mudarCor()
					local explosao = Explosao.new(carro.x, carro.y)
					carro:removeSelf( )
					carro = nil
					local pts = tonumber( pontos.text ) * 1000
					print(pts)
					submitHighScore("CgkIi7_A79oJEAIQBQ",pts)
					showLeaderboards()
					transition.pause( obstaculo )
        		end
    		end
		end
		Runtime:addEventListener( "collision", onCollision )
	end
end
--------------------------------------------------------------------------------

-- Called when scene is about to move offscreen:
function scene:hide( event )
	local group = self.view

end
--------------------------------------------------------------------------------


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