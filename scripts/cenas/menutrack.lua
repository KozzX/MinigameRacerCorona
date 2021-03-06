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


end


-- Called immediately after scene has moved onscreen:
function scene:show( event )
	local group = self.view

	if event.phase == "will" then
		local bg = display.newImage( "images/background.png", true)
		bg.anchorX, bg.anchorY = 0, 0
		local title1 = display.newText( SPLAY, display.contentCenterX, display.contentHeight / 25 * 2.5, "Bitwise", 50)
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

	elseif event.phase == "did" then
		grupoMenu = display.newGroup( )
		local btn
		local btn2
		local btn3
		local i = 1
		
		local function tracks2( event )
  			composer.gotoScene( "scripts.cenas.2tracks.menu", {effect = "slideLeft",time = 300} )
  			btn3:removeEventListener( "tap", tracks2 )
  			composer.removeScene( scene )
		end
		local function tracks3( event )
			--native.showAlert( SALERT, SSOON, { "Ok" })
  			composer.gotoScene( "scripts.cenas.3tracks.menu", {effect = "slideLeft",time = 300} )
  			btn2:removeEventListener( "tap", tracks3 )
  			composer.removeScene( scene )
		end
		local function tracks4( event )
			--native.showAlert( SALERT, SSOON, { "Ok" })
  			composer.gotoScene( "scripts.cenas.4tracks.menu", {effect = "slideLeft",time = 300} )
  			btn:removeEventListener( "tap", tracks4 )
  			composer.removeScene( scene )
		end
		local function back( event )
  			composer.gotoScene( "scripts.cenas.mainmenu", {effect = "slideRight",time = 300} )
  			btn4:removeEventListener( "tap", back )
  			composer.removeScene( scene )
		end
		
		
		function criarMenu (event)
			if i == 1 then
				btn = Botao.newPlayButton(S4TRACKS,display.contentHeight / 25 * 5)
				btn:addEventListener( "tap", tracks4 )
				grupoMenu:insert( btn )
			elseif i == 2 then
				btn2 = Botao.newPlayButton(S3TRACKS,display.contentHeight / 25 * 7.3)
				btn2:addEventListener( "tap", tracks3 )
				grupoMenu:insert( btn2 )
			elseif i == 3 then
				btn3 = Botao.newPlayButton(S2TRACKS,display.contentHeight / 25 * 9.6)
				btn3:addEventListener( "tap", tracks2 )
				grupoMenu:insert( btn3 )
			elseif i == 4 then
				btn4 = Botao.newPlayButton(SBACK,display.contentHeight / 25 * 18.8)
				btn4:addEventListener( "tap", back )
				grupoMenu:insert( btn4 )
			end
			i = i + 1
		end
		timerMenu = timer.performWithDelay( 50, criarMenu ,7 )	
	end 	
end


-- Called when scene is about to move offscreen:
function scene:hide( event )
	local group = self.view
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