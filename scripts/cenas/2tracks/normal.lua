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
local telaX = display.contentWidth
local telaY = display.contentHeight
local GAMEMODE = "2TRACKS-NORMAL"

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
        pista1 = Pista.new(posX(4),posY(0))
        pista2 = Pista.new(posX(11),posY(0))

    elseif event.phase == "did" then
        
        
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
        local faixa = display.newRoundedRect( posX(1),posX(0.5),display.contentWidth-posX(2), posY(2.7),10 )
        faixa:setFillColor( 0.6,0,0 )
        faixa.anchorX = 0
        faixa.anchorY = 0
        
        grupoObjetos.alpha = 0
        --grupoObjetos:insert(bg)
        grupoObjetos:insert(carro)
        grupoObjetos:insert(faixa)
        grupoPistas:insert(pista1)
        grupoPistas:insert(pista2)
        grupoObjetos:insert( grupoHUD )
        grupoHUD:insert(pontos)
        grupoHUD:insert(pontosDif)
        grupoHUD:insert(pontosNome)
        grupoHUD:insert(pontosDifNome)

        function comecar()
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
            faixa.alpha = 0.2
            transition.scaleTo( tap, {xScale=2.0, yScale=2.0, time=1000,onComplete=removerTap} )
            transition.to( tap, {time = 1000, alpha = 0} )
            transition.moveTo( carro, {x=carro.x, y=posY(19), time = 700,onComplete=adicionarControle} )
            comecou = true
            
            Runtime:removeEventListener("tap",comecar) 
        end
        Runtime:addEventListener("tap",comecar)

    

        function onTouch(event)
            if(event.phase == "began") then
                if (event.x < telaX / 2) and (carro.x >= posX(6)) then
                    pontos.text = pontos.text + (1)
                    pontosDif.text = pontos.text - pontosProximo
                    transition.moveTo( carro, {x = carro.x - posX(3), y = carro.y, time = 50} )
                elseif (event.x > telaX / 2) and (carro.x <= posX(7)) then
                    pontos.text = pontos.text + (1)
                    pontosDif.text = pontos.text - pontosProximo
                    transition.moveTo( carro, {x = carro.x + posX(3), y = carro.y, time = 50} )
                end
                if((pontos.text - pontosProximo) > 0) then
                    faixa:setFillColor(0,1,0)
                    pontosDif.text = "SUCCESS"
                end
            end
        end

        if(carregado == true) then
            if (getMainPlayer()>1) then
                pontosProximo = (getPlayerByIndex(getMainPlayer()-1).score)
            else
                pontosProximo = (getPlayerByIndex(getMainPlayer()).score) 
            end   
        else
            pontosProximo = buscarPontos(GAMEMODE).highScore
        end
        pontosDif.text = -(pontosProximo)

        
        


        function carregarObstaculo( event )
            if comecou == false then
                tempo = 0
            end

            if tempo == target then
                obstaculo1[i] = Carro.newObstaculo(math.random(2,3))
                grupoObjetos:insert( obstaculo1[i] )

                --obstaculo2[i] = Carro.newObstaculo(math.random(2,3))
                --grupoObjetos:insert( obstaculo2[i] )
                --obstaculo3[i] = Carro.newObstaculo(math.random(3,3))
                --grupoObjetos:insert( obstaculo3[i] )
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
                    pontos:toFront( )
                    pontosDif:toFront( )
                    if((pontos.text - pontosProximo) > 0) then
                        faixa:setFillColor(0,1,0)
                        pontosDif.text = "SUCCESS"
                    else
                        pontosDif.text = pontos.text - pontosProximo
                        pontosDif.text = string.format( "%6.0f", pontosDif.text )

                    end
                end
            end
        end
        Runtime:addEventListener("enterFrame",somarPontos)
        
        local function onCollision( event )
            if event.phase == "began" then
                local agro = event.object1
                local hit = event.object2
     
                if agro.type == "carro" and hit.type == "obstaculo" then
                    local pts = tonumber(pontos.text)
                    Runtime:removeEventListener( "touch", onTouch )
                    Runtime:removeEventListener( "enterFrame", enterFrameListener )
                    Runtime:removeEventListener( "enterFrame", carregarObstaculo )
                    Runtime:removeEventListener("enterFrame",somarPontos)
                    transition.pause(obstaculo1[i])
                    submeterPontos(GAMEMODE,pts)
                    pista1:pause( )
                    pista2:pause( )
                    explosao = Explosao.new(carro.x,carro.y)
                    carro.isVisible = false
                    grupoObjetos:insert(explosao)
                    local table = display.newRoundedRect( display.contentWidth,display.contentHeight / 25 * 4,display.contentWidth / 16 * 14, display.contentHeight/25*15,10 )
                    table.anchorY = 0
                    table.stroke = {0,0,0}
                    table.strokeWidth = 4
                    table:setFillColor( 0.7,0.7,0.7 )
                    transition.to( table, {x=display.contentCenterX,alpha=0.85, time=400} )

                    local scoreLabel = display.newText( "Score", display.contentWidth + posX(5), posY(6), "Bitwise", 40)
                    scoreLabel:setFillColor( 0,0,0 )
                    local bestLabel = display.newText( "Best", display.contentWidth + posX(11), posY(6), "Bitwise", 40)
                    bestLabel:setFillColor( 0,0,0 )

                    local score = display.newText( buscarPontos(GAMEMODE).lastScore, display.contentWidth + posX(5), posY(10), "Bitwise", 70)
                    score:setFillColor( 0,0,0 )
                    local best = display.newText( buscarPontos(GAMEMODE).highScore, display.contentWidth + posX(11), posY(10), "Bitwise", 70)
                    best:setFillColor( 0,0,0 )

                    bestLabel.alpha,best.alpha,scoreLabel.alpha,score.alpha = 0,0,0,0
                    transition.moveTo( scoreLabel, {x=posX(5), time=400} )
                    transition.moveTo( bestLabel, {x=posX(11), time=400} )
                    transition.moveTo( score, {x=posX(5), time=400} )
                    transition.moveTo( best, {x=posX(11), time=400} )
                    transition.to( scoreLabel, {alpha=1, time=1000} )
                    transition.to( bestLabel, {alpha=1, time=1000} )
                    transition.to( score, {alpha=1, time=1000} )
                    transition.to( best, {alpha=1, time=1000} )

                    grupoObjetos:insert(table)
                    grupoObjetos:insert(scoreLabel)
                    grupoObjetos:insert(bestLabel)
                    grupoObjetos:insert(score)
                    grupoObjetos:insert(best)
                    local botaoResult

                    function result( event )
                        --composer.gotoScene( "scripts.cenas.result", { effect = "slideLeft", time = 300 } )
                        composer.gotoScene( "scripts.cenas.2tracks.loading", {effect = "fade",time = 300, params={tabela=IDLEADERBOARDS.tracks2normal, pontos=pts, cena="scripts.cenas.result"}} )
                        display.remove(grupoObjetos)
                        botaoResult:removeEventListener( "tap", result )
                        display.remove( botaoResult )
                    end
                    botaoResult = Botao.newPlayButton("Next",display.contentHeight / 25 * 16)
                    botaoResult:addEventListener( "tap", result )
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
