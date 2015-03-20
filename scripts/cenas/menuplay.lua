local composer = require( "composer" )
local scene = composer.newScene()
local Botao = require( "scripts.objetos.Botao" )

local grupoMenu


---------------------------------------------------------------------------------
-- SCENE EVENTS
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:create( event )
	local group = self.view
	local bg = display.newImage( "images/background.png", true)
	bg.anchorX, bg.anchorY = 0, 0
	local title1 = display.newText( "PLAY", display.contentCenterX, display.contentHeight / 25 * 2.5, "Bitwise", 50)
	--local title2 = display.newText( "RACER", display.contentCenterX, display.contentHeight / 25 * 4, "Bitwise", 50)
	title1:setFillColor( 0,0,0 )
	--title2:setFillColor( 0,0,0 )
	local table = display.newRoundedRect( display.contentCenterX,display.contentHeight / 25 * 1 ,display.contentWidth / 16 * 14, display.viewableContentHeight-100,10 )
	table.anchorY = 0
	table.stroke = {0,0,0}
	table.strokeWidth = 4
	table:setFillColor( 0.7,0.7,0.7 )
	
	group:insert( bg )
	group:insert( table )
	group:insert( title1 )
	--group:insert( title2 )

end


-- Called immediately after scene has moved onscreen:
function scene:show( event )
	local group = self.view

	if event.phase == "will" then
		loadInter()

	elseif event.phase == "did" then
		grupoMenu = display.newGroup( )
		local btn
		local btn2
		local btn3
		local i = 1
		local function arcade( event )
  			composer.gotoScene( "scripts.cenas.arcade2-1.menu", {effect = "fade",time = 300} )
  			btn:removeEventListener( "tap", arcade )
		end
		local function leaderboards ( event )
			showLeaderboards()
		end
		local function achievements ( event )
			showAchievements()
		end
		local function buy ( event )
			
		end
		
		function criarMenu (event)
			if i == 1 then
				btn = Botao.newPlayButton("Arcade",display.contentHeight / 25 * 5)
				btn:addEventListener( "tap", arcade )
				grupoMenu:insert( btn )
			elseif i == 2 then
				btn2 = Botao.newPlayButton("Story",display.contentHeight / 25 * 8.3)
				grupoMenu:insert( btn2 )
			elseif i == 3 then
				btn3 = Botao.newPlayButton("Multiplayer",display.contentHeight / 25 * 11.6)
				btn3:addEventListener( "tap", buy )
				grupoMenu:insert( btn3 )
			elseif i == 4 then
				btn4 = Botao.newPlayButton("Back",display.contentHeight / 25 * 14.9)
				btn4:addEventListener( "tap", leaderboards )
				grupoMenu:insert( btn4 )
			end
			i = i + 1
		end
		timerMenu = timer.performWithDelay( 100, criarMenu ,5 )	
	end 	
end


-- Called when scene is about to move offscreen:
function scene:hide( event )
	local group = self.view
	hideBanner()
	display.remove(grupoMenu)
	timer.cancel( timerMenu )
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroy( event )
	local group = self.view
	
end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene