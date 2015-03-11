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
--local carro
local obstaculo1 = {}
local obstaculo2 = {}

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
        --local carro = nil
        
        --sceneGroup:insert( bg )
        --sceneGroup:insert(carro) 
        local bg = Background.new()
        local i = 1
        local j = 1
        local k = 1
        local grupoObs = display.newGroup( )
        local grupoCar = display.newGroup( )

        
        local carro = Carro.newCarro(5,19)
        grupoCar:insert( carro )
        print( "criado",carro )
        
        function carregarObstaculo( event )
            obstaculo1[i] = Carro.newObstaculo(math.random(1,4))
            --obstaculo2[i] = Carro.newObstaculo(math.random(1,4))
            grupoObs:insert(obstaculo1[i])
            --grupoObs:insert(obstaculo2[i])
            transition.moveTo(obstaculo1[i],{x = obstaculo1[i].x, y=posY(22), time = 1000, onComplete=remover})
            --transition.moveTo(obstaculo2[i],{x = obstaculo2[i].x, y=posY(22), time = 1000})
            i = i + 1
        end
        timerObstaculo = timer.performWithDelay( 500, carregarObstaculo, -1 )

        function remover( event )
            display.remove(obstaculo1[j])
            obstaculo1[j] = nil
            --obstaculo2[j]:removeSelf( )
            --obstaculo2[j] = nil
            j = j + 1
        end
        


        local function onCollision( event )
            if event.phase == "began" then
                local agro = event.object1
                local hit = event.object2
     
                if agro.type == "carro" and hit.type == "obstaculo" then
                    timer.cancel( timerObstaculo )
                    
                    Runtime:removeEventListener( "enterFrame", enterFrameListener )
                    print( "removido",grupoCar)
                    local explosao = Explosao.new(grupoCar.x, grupoCar.y)
                    print( i )
                    transition.pause( obstaculo1[i+1] )                   
                    display.remove( grupoCar )
                    --grupoCar = nil

                    function nextScene ( event )
                        local phase = event.phase
                        if "ended" == phase then
                            --Runtime:removeEventListener( "collision", onCollision )
                            Runtime:removeEventListener( "touch", nextScene )
                            composer.gotoScene( "scripts.cenas.mainmenu", { effect = "fade", time = 300 } )
                            display.remove(explosao)
                            explosao = nil
                            display.remove(grupoObs)
                            --grupoObs = nil
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
