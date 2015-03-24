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

		if(logado == true) then
			local players = getPlayerList()
			local label
		
			local i = 1
			local j = 1
		
			if (getMainPlayer() > 7) then
				i = getMainPlayer() - 7
			elseif (getMainPlayer() > 6) then
				i = getMainPlayer() - 6
			elseif (getMainPlayer() > 5) then
				i = getMainPlayer() - 5
			elseif (getMainPlayer() > 4) then
				i = getMainPlayer() - 4
			elseif (getMainPlayer() > 3) then
				i = getMainPlayer() - 3
			elseif (getMainPlayer() > 2) then
				i = getMainPlayer() - 2
			elseif (getMainPlayer() > 1) then
				i = getMainPlayer() - 1
			end

			function criarMenu (event)
				label = display.newText( players[i].rank .. ") " .. players[i].nome .. " " .. players[i].score, display.contentWidth/2, posY(j+3.5), "Bitwise", 25)
				if(getMainPlayer() == i) then
					label:setFillColor( 0.7,0,0 )
				else
					label:setFillColor( 0,0,0 )
				end
				label.anchorX = 0
				label.alpha = 0
				transition.moveTo( label, {x=posX(2), time=400} )
				transition.to( label, {alpha=1, time=500} )
				grupoMenu:insert(label)
				i = i + 1
				j = j + 1
			end
			timerMenu = timer.performWithDelay( 50, criarMenu ,15 )	
		end
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