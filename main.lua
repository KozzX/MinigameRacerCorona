
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
		--native.showAlert( "Erro", "Logado " .. playerName .. " " .. globalGoogleScore, { "Ok" })
		composer.gotoScene( "scripts.cenas.mainmenu" )
		explosao:removeSelf( )
		explosao = nil
		timer.cancel( timerstart )
	end
	
end
timerstart = timer.performWithDelay( 1000, start, -1 )





