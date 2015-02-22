
local composer = require "composer"
local Google = require("scripts.util.Google")
local Explosao = require("scripts.objetos.Explosao")
--local performance = require('performance')
--performance:newPerformanceMeter()

loginGooglePlay()
local explosao = Explosao.newLoad(display.contentWidth / 2, display.contentHeight / 2)

function start( event )
	loadHighScore("CgkIi7_A79oJEAIQBQ")
	composer.gotoScene( "scripts.cenas.mainmenu" )
	explosao:removeSelf( )
	explosao = nil
end
timerstart = timer.performWithDelay( 5000, start, 1 )


