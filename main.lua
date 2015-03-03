
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
		local player1 = display.newText( textPontos )
		player1.anchorX ,player1.anchorY = 0,0
		player1.text = rank[1] .. ") " .. playerName[1] .. " - " .. score[1]
		local player2 = display.newText( textPontos )
		player2.anchorX ,player2.anchorY = 0,0
		player2.text = rank[2] .. ") " .. playerName[2] .. " - " .. score[2]
		player2.y = 100
		local player3 = display.newText( textPontos )
		player3.anchorX ,player3.anchorY = 0,0
		player3.text = rank[3] .. ") " .. playerName[3] .. " - " .. score[3]
		player3.y = 200
		local player4 = display.newText( textPontos )
		player4.anchorX ,player4.anchorY = 0,0
		player4.text = rank[4] .. ") " .. playerName[4] .. " - " .. score[4]
		player4.y = 300
		local player5 = display.newText( textPontos )
		player5.anchorX ,player5.anchorY = 0,0
		player5.text = rank[5] .. ") " .. playerName[5] .. " - " .. score[5]
		player5.y = 400
		

		--composer.gotoScene( "scripts.cenas.mainmenu" )
		--explosao:removeSelf( )
		--explosao = nil
		--timer.cancel( timerstart )
	end
	
end
timerstart = timer.performWithDelay( 1000, start, -1 )





