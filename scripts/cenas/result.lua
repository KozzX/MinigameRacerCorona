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
	local title1 = display.newText( "RESULTS", display.contentCenterX, display.contentHeight / 25 * 2.5, "Bitwise", 50)
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

	elseif event.phase == "did" then
		grupoMenu = display.newGroup( )
		local players = getPlayerList()
		local label
		local btn2
		local btn3
		local i = 1
		local function easy( event )
  			composer.gotoScene( "scripts.cenas.arcade2-1.easy.easy", {effect = "fade",time = 300} )
  			btn:removeEventListener( "tap", easy )
		end

		
		
		function criarMenu (event)
			label = display.newText( players[i].rank .. ") " .. players[i].nome .. " " .. players[i].score, display.contentWidth/2, posY(i+4), "Bitwise", 40)
			label:setFillColor( 0,0,0 )
			label.anchorX = 0
			label.alpha = 0
			transition.moveTo( label, {x=posX(4), time=400} )
			transition.to( label, {alpha=1, time=500} )
			label:addEventListener( "tap", easy )
			grupoMenu:insert(label)
			i = i + 1
		end
		timerMenu = timer.performWithDelay( 50, criarMenu ,#players )	
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