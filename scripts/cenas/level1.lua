---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local Carro = require( "scripts.objetos.Carro" )
local Background = require( "scripts.objetos.Background" )
local Explosao = require( "scripts.objetos.Explosao" )
local Pista = require( "scripts.objetos.Pista" )

-- Load scene with same root filename as this file
local scene = composer.newScene(  )

---------------------------------------------------------------------------------
local bg
local carro
local obstaculo1 = {}
local obstaculo2

physics.start( )
physics.setGravity( 0, 0 )

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then

    elseif phase == "did" then

        bg = Background.new()
        carro = Carro.newCarro(5,19)
        sceneGroup:insert( bg )
        sceneGroup:insert(carro) 

        local i = 1
        
        function carregarObstaculo( event )
            obstaculo1[i] = Carro.newObstaculo(math.random(1,4))

            --obstaculo2 = Carro.newObstaculo(math.random(1,4))
            --local obstaculo = Carro.newObstaculo(math.random(1,4))
            --local obstaculo = Carro.newObstaculo(math.random(1,4))
        end
        timerObstaculo = timer.performWithDelay( 500, carregarObstaculo, -1 )
        


        local function onCollision( event )
            if event.phase == "began" then
                local agro = event.object1
                local hit = event.object2
     
                if agro.type == "carro" and hit.type == "obstaculo" then
                    timer.cancel( timerObstaculo )
                    Runtime:removeEventListener( "enterFrame", enterFrameListener )
                    local explosao = Explosao.new(carro.x, carro.y)
                    transition.pause( obstaculo1 )
                    transition.pause( obstaculo2 )
                    carro:removeSelf( )
                    carro = nil
                    --pista1:pause( )
                    --pista2:pause( )
                    --local botao = Botao.newPlayButton()
                    --transition.to( botao, {time = 1000, alpha = 1} )
                    --botao:addEventListener("tap",esperaBotao)
                    function nextScene ( event )
                        local phase = event.phase
                        if "ended" == phase then
                            composer.gotoScene( "scripts.cenas.mainmenu", { effect = "fade", time = 300 } )
                            explosao:removeSelf( )
                        end
                    end
                    Runtime:addEventListener( "touch", nextScene )
                end
            end
        end
        Runtime:addEventListener( "collision", onCollision )



        
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
    elseif phase == "did" then
        -- Called when the scene is now off screen

        bg:removeSelf( )
        bg = nil
		Runtime:removeEventListener( "touch", nextScene )
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
