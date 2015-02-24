
local composer = require "composer"
local Google = require("scripts.util.Google")
local Explosao = require("scripts.objetos.Explosao")
--local performance = require('performance')
--performance:newPerformanceMeter()
--loginGooglePlay()
gameNetworkSetup()

local explosao = Explosao.newLoad(display.contentWidth / 2, display.contentHeight / 2)

function start( event )
	if(logado==true) then
		native.showAlert( "Erro", "Logado " .. playerName .. " " .. globalGoogleScore, { "Ok" })
		timer.cancel( timerstart )
	end

	--if (playerConnected()) then	
	--loadHighScore("CgkIi7_A79oJEAIQBQ")
	--composer.gotoScene( "scripts.cenas.mainmenu" )
	--explosao:removeSelf( )
	--explosao = nil
	--timer.cancel( timerstart )
end
timerstart = timer.performWithDelay( 1, start, -1 )





