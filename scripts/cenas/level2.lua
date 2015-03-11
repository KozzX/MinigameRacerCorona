local composer = require( "composer" )
local Carro = require( "scripts.objetos.Carro" )
local Background = require( "scripts.objetos.Background" )
local Botao = require( "scripts.objetos.Botao" )
local Explosao = require( "scripts.objetos.Explosao" )

local scene = composer.newScene(  )

physics.start( )
physics.setGravity( 0, 0 )

---------------------------------------------------------------------------------

function scene:create( event )
    local sceneGroup = self.view
    local bg = Background.new()
    sceneGroup:insert(bg)
end

function scene:show( event )
    local sceneGroup = self.view

    if event.phase == "will" then
        
    elseif event.phase == "did" then
        local i = 1
        local grupoObjetos = display.newGroup( )
        local carro = Carro.newCarro(5,19)
        local obstaculo = {}
        local explosao
        grupoObjetos:insert(carro)

        

        function carregarObstaculo( event )
            obstaculo[i] = Carro.newObstaculo(math.random(1,4))
            grupoObjetos:insert( obstaculo[i] )
            i = i + 1
        end
        timerObstaculo = timer.performWithDelay( 500, carregarObstaculo, -1 )
        
        local function onCollision( event )
            if event.phase == "began" then
                local agro = event.object1
                local hit = event.object2
     
                if agro.type == "carro" and hit.type == "obstaculo" then
                    timer.cancel( timerObstaculo )
                    transition.pause(obstaculo[i])
                    explosao = Explosao.new(carro.x,carro.y)
                    display.remove( carro )
                    grupoObjetos:insert(explosao)
                    local botao = Botao.newPlayButton()
                    --otao.y = 100
                    
                    function nextScene ( event )
                        composer.gotoScene( "scripts.cenas.mainmenu", { effect = "fade", time = 300 } )
                        display.remove(grupoObjetos)
                        botao:removeEventListener( "tap", nextScene )
                        display.remove( botao )
                    end
                    botao:addEventListener( "tap", nextScene )
                    Runtime:removeEventListener( "collision", onCollision )
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
        
    elseif phase == "did" then

    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
