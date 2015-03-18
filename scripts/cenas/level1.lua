local composer = require( "composer" )
local Carro = require( "scripts.objetos.Carro" )
local Background = require( "scripts.objetos.Background" )
local Botao = require( "scripts.objetos.Botao" )
local Explosao = require( "scripts.objetos.Explosao" )
local Pista = require( "scripts.objetos.Pista" )
local Pontos = require( "scripts.objetos.PontosHUD" )

local scene = composer.newScene(  )

physics.start( )
physics.setGravity( 0, 0 )

local tap
local pista1
local pista2

---------------------------------------------------------------------------------

function scene:create( event )
    local sceneGroup = self.view
    local bg = Background.new()
    sceneGroup:insert(bg)

end

function scene:show( event )
    local sceneGroup = self.view

    if event.phase == "will" then
        tap = display.newImage( "images/tap.png", display.contentCenterX,display.contentCenterY )
        pista1 = Pista.new(posX(1),posY(0))
        pista2 = Pista.new(posX(14),posY(0))

    elseif event.phase == "did" then
        showBanner()
        local i = 1
        local j = 1
        local grupoObjetos = display.newGroup( )
        local grupoPistas = display.newGroup( )
        local grupoHUD = display.newGroup( )
        local carro = Carro.newCarro(5,25)
        local obstaculo1 = {}
        local obstaculo2 = {}
        local obstaculo3 = {}
        local explosao
        local pontos = Pontos.newPontos()
        local pontosDif = Pontos.newPontosDif()
        local pontosNome = Pontos.newPontosNome()
        local pontosDifNome = Pontos.newPontosDifNome()
        local pontosProximo = 0
        local tempo = 0
        local target = 100
        local comecou = false


        grupoObjetos.alpha = 0
        grupoObjetos:insert(carro)
        grupoPistas:insert(pista1)
        grupoPistas:insert(pista2)
        grupoObjetos:insert( grupoHUD )
        grupoHUD:insert(pontos)
        grupoHUD:insert(pontosDif)
        grupoHUD:insert(pontosNome)
        grupoHUD:insert(pontosDifNome)

        if(logado == true) then
            pontosProximo = (getPlayerByIndex(getMainPlayer()-1).score)
        else
            pontosProximo = 20
        end
        pontosDif.text = -(pontosProximo)

        Runtime:removeEventListener( "touch", onTouch )

        function comecar(event)
            pontos.text = 0

            function adicionarControle()
                grupoObjetos:insert( grupoPistas )
                Runtime:addEventListener( "touch", onTouch )
            end
            function removerTap( event )
                display.remove( tap )
                tap = nil
            end
            
            transition.to( grupoObjetos, {time = 500,alpha = 1} )
            transition.scaleTo( tap, {xScale=2.0, yScale=2.0, time=1000,onComplete=removerTap} )
            transition.to( tap, {time = 1000, alpha = 0} )
            transition.moveTo( carro, {x=carro.x, y=posY(19), time = 700,onComplete=adicionarControle} )
            comecou = true
            
            Runtime:removeEventListener("tap",comecar) 
        end
        Runtime:addEventListener("tap",comecar)

        function carregarObstaculo( event )
            if comecou == false then
                tempo = 0
            end

            if tempo == target then
                obstaculo1[i] = Carro.newObstaculo(math.random(1,2))
                grupoObjetos:insert( obstaculo1[i] )
                obstaculo2[i] = Carro.newObstaculo(math.random(2,3))
                grupoObjetos:insert( obstaculo2[i] )
                obstaculo3[i] = Carro.newObstaculo(math.random(3,3))
                grupoObjetos:insert( obstaculo3[i] )
                i = i + 1
                tempo = 0
                target = 40
            end
            tempo = tempo + 1
            
        end
        Runtime:addEventListener("enterFrame",carregarObstaculo)

        function somarPontos( event )
            if obstaculo1[j] ~= nil then
                if(obstaculo1[j].y) >= carro.y then
                    j = j + 1 
                    pontos.text = pontos.text + (1)
                    pontos.text = string.format( "%6.0f", pontos.text )
                    if logado == true then
                        pontosDif.text = pontos.text - pontosProximo
                    else
                        pontosDif.text = pontos.text - pontosProximo
                    end 
                    pontosDif.text = string.format( "%6.0f", pontosDif.text )
                    pontos:toFront( )
                    pontosDif:toFront( )
                end
            end
        end
        Runtime:addEventListener("enterFrame",somarPontos)
        
        local function onCollision( event )
            if event.phase == "began" then
                local agro = event.object1
                local hit = event.object2
     
                if agro.type == "carro" and hit.type == "obstaculo" then
                    showInter()
                    Runtime:removeEventListener( "enterFrame", enterFrameListener )
                    Runtime:removeEventListener( "enterFrame", carregarObstaculo )
                    Runtime:removeEventListener("enterFrame",somarPontos)
                    transition.pause(obstaculo1[i])
                    pista1:pause( )
                    pista2:pause( )
                    explosao = Explosao.new(carro.x,carro.y)
                    carro.isVisible = false
                    grupoObjetos:insert(explosao)
                    local botao = Botao.newPlayButton()
                    
                    function nextScene ( event )
                        composer.gotoScene( "scripts.cenas.mainmenu", { effect = "fade", time = 300 } )
                        display.remove(grupoObjetos)
                        hideBanner()
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
