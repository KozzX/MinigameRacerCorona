
local composer = require "composer"
local Google = require("scripts.util.Google")
local Explosao = require("scripts.objetos.Explosao")




local explosao = Explosao.newLoad(display.contentWidth / 2, display.contentHeight / 2)

local function verificar( event )
	if event.action == "clicked" then
        local i = event.index
        if i == 1 then
        	gameNetworkSetup()
        elseif i == 2 then
        	composer.gotoScene( "scripts.cenas.mainmenu" )
			explosao:removeSelf( )
			explosao = nil
			timer.cancel( timerstart )
		end
	end
end

native.showAlert( "Minigame Racer","Para que todos os recursos do jogo estejam disponíveis, é necessário fazer o login com o Google Play Games", { "Login","Cancel" }, verificar)




function start( event )
	if(logado==true) then
		--native.showAlert( "Leaderboard", playerName[1], { "Ok" })
		local textPontos = 
		{
    		text = "player",     
    		font = native.newFont( "8_bit_1_6", 25 ),
    		fontSize = 25 
		}

		--for i = 1,playersID.
		local playersInfo = display.newText( textPontos )
		playersInfo.anchorX ,playersInfo.anchorY = 0,0
		playersInfo.text = playerName[1] .. rank[1] .. scores[1]
		

		--composer.gotoScene( "scripts.cenas.mainmenu" )
		--explosao:removeSelf( )
		--explosao = nil
		--timer.cancel( timerstart )
	end
	
end
timerstart = timer.performWithDelay( 1000, start, -1 )





