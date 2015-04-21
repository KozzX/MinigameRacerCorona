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
	
	--group:insert( title2 )

end


-- Called immediately after scene has moved onscreen:
function scene:show( event )
	local group = self.view

	if event.phase == "will" then
		local bg = display.newImage( "images/background.png", true)
		bg.anchorX, bg.anchorY = 0, 0
		local title1 = display.newText( SOPTIONS, display.contentCenterX, display.contentHeight / 25 * 2.5, "Bitwise", 50)
		local labelSound = display.newText( SSOUND, display.contentCenterX, display.contentHeight / 25 * 5, "Bitwise", 40)
		local labelLanguage = display.newText( SLANGUAGE, display.contentCenterX, display.contentHeight / 25 * 12, "Bitwise", 40)
		title1:setFillColor( 0,0,0 )
		labelSound:setFillColor( 0,0,0 )
		labelLanguage:setFillColor( 0,0,0 )
		local table = display.newRoundedRect( display.contentCenterX,display.contentHeight / 25 * 1 ,display.contentWidth / 16 * 14, display.viewableContentHeight-100,10 )
		table.anchorY = 0
		table.stroke = {0,0,0}
		table.strokeWidth = 4
		table:setFillColor( 0.7,0.7,0.7 )
	
		group:insert( bg )
		group:insert( table )
		group:insert( title1 )
		group:insert( labelSound )
		group:insert( labelLanguage )

	elseif event.phase == "did" then
		grupoMenu = display.newGroup( )
		local btn
		local btn2
		local btn3
		local i = 1
		
		local function enable( event )
			audio.setVolume( 1, { channel=0 } )
			audio.setVolume( 0.5, { channel=1 } )
		end
		local function disable( event )
			audio.setVolume( 0, { channel=0 } )
		end
		local function english( event )
			--native.showAlert( SALERT, SSOON, { "Ok" })
			setLanguage("en")
			saveLang("en")
  			composer.gotoScene( "scripts.cenas.options", {effect = "slideLeft",time = 300} )
  			btn3:removeEventListener( "tap", english )
  			composer.removeScene( scene )
		end
		local function portuguese( event )
			--native.showAlert( SALERT, SSOON, { "Ok" })
			setLanguage("pt")
			saveLang("pt")
  			composer.gotoScene( "scripts.cenas.options", {effect = "slideLeft",time = 300} )
  			btn3:removeEventListener( "tap", portuguese )
  			composer.removeScene( scene )
		end
		local function back( event )
  			composer.gotoScene( "scripts.cenas.mainmenu", {effect = "slideRight",time = 300} )
  			btn5:removeEventListener( "tap", back )
  			composer.removeScene( scene )
		end
		
		
		function criarMenu (event)
			if i == 1 then
				btn = Botao.newPlayButton(SENABLED,display.contentHeight / 25 * 6)
				btn:addEventListener( "tap", enable )
				grupoMenu:insert( btn )
			elseif i == 2 then
				btn2 = Botao.newPlayButton(SDISABLED,display.contentHeight / 25 * 8.3)
				btn2:addEventListener( "tap", disable )
				grupoMenu:insert( btn2 )
			elseif i == 3 then
				btn3 = Botao.newPlayButton(SENGLISH,display.contentHeight / 25 * 13)
				btn3:addEventListener( "tap", english )
				grupoMenu:insert( btn3 )
			elseif i == 4 then
				btn4 = Botao.newPlayButton(SPORTUGUESE,display.contentHeight / 25 * 15.3)
				btn4:addEventListener( "tap", portuguese )
				grupoMenu:insert( btn4 )
			elseif i == 5 then
				btn5 = Botao.newPlayButton(SBACK,display.contentHeight / 25 * 18.8)
				btn5:addEventListener( "tap", back )
				grupoMenu:insert( btn5 )
			end
			i = i + 1
		end
		timerMenu = timer.performWithDelay( 50, criarMenu ,5 )	
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