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
	local params = event.params

	if event.phase == "will" then
		showBanner()
		local bg = display.newImage( "images/background.png", true)
		bg.anchorX, bg.anchorY = 0, 0
		local title1 = display.newText( SRESULT, display.contentCenterX, display.contentHeight / 25 * 2.5, "Bitwise", 50)
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
		print( params.retry )

		if(carregado == true) then
			local players = getPlayerList()
			local labelPlayer	
		
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

			local function carregarNomes (event)
				labelPlayer = display.newText( players[i].rank .. ") " .. players[i].nome .. " " .. players[i].score, display.contentWidth/2, posY(j+3.5), "Bitwise", 25)
				if(getMainPlayer() == i) then
					labelPlayer:setFillColor( 0.7,0,0 )
				else
					labelPlayer:setFillColor( 0,0,0 )
				end
				labelPlayer.anchorX = 0
				labelPlayer.alpha = 0
				transition.moveTo( labelPlayer, {x=posX(2), time=400} )
				transition.to( labelPlayer, {alpha=1, time=500} )
				grupoMenu:insert(labelPlayer)
				i = i + 1
				j = j + 1
				if j >= 15 then
					timer.cancel(timerNomes)
				end
			end
			timerNomes = timer.performWithDelay( 50, carregarNomes ,15 )
		else
			local labelMatch
			local labelTotal
			local labelAvg
			local labelBest
			local labelLast
			local stats = buscarPontos(params.mode)

			local avg
			if(stats.timesPlayed > 0)then
				avg = stats.totalScore/stats.timesPlayed
				avg = string.format( "%0.0f", avg )
			else
				avg = 0
				avg = string.format( "%0.0f", avg )
			end

			labelMatch = display.newText( SMATCH .. stats.timesPlayed, display.contentWidth/2, posY(4.5), "Bitwise", 35)
			labelTotal = display.newText( STOTAL .. stats.totalScore, display.contentWidth/2, posY(6.5), "Bitwise", 35)
			labelAvg   = display.newText( SAVG .. avg, display.contentWidth/2, posY(8.5), "Bitwise", 35)
			labelBest  = display.newText( SBESTS .. stats.highScore, display.contentWidth/2, posY(10.5), "Bitwise", 35)
			labelLast  = display.newText( SLAST .. stats.lastScore, display.contentWidth/2, posY(12.5), "Bitwise", 35)
			
			labelMatch.anchorX = 0
			labelTotal.anchorX = 0 
			labelAvg.anchorX = 0   
			labelBest.anchorX = 0  
			labelLast.anchorX = 0

			labelMatch.alpha = 0
			labelTotal.alpha = 0
			labelAvg.alpha = 0  
			labelBest.alpha = 0 
			labelLast.alpha = 0 

			labelMatch:setFillColor( 0,0,0 )
			labelTotal:setFillColor( 0,0,0 )
			labelAvg:setFillColor( 0,0,0 )
			labelBest:setFillColor( 0,0,0 )
			labelLast:setFillColor( 0,0,0 )

			transition.moveTo( labelMatch, {x=posX(2), time=400} )
			transition.moveTo( labelTotal, {x=posX(2), time=400} )
			transition.moveTo( labelAvg  , {x=posX(2), time=400} )
			transition.moveTo( labelBest , {x=posX(2), time=400} )
			transition.moveTo( labelLast , {x=posX(2), time=400} )
			
			transition.to( labelMatch, {alpha=1, time=500} )
			transition.to( labelTotal, {alpha=1, time=500} )
			transition.to( labelAvg  , {alpha=1, time=500} )
			transition.to( labelBest , {alpha=1, time=500} )
			transition.to( labelLast , {alpha=1, time=500} )


			grupoMenu:insert(labelMatch)
			grupoMenu:insert(labelTotal)
			grupoMenu:insert(labelAvg)
			grupoMenu:insert(labelBest)
			grupoMenu:insert(labelLast)



			local function carregarStats(event)

			end
		end 


		local btn
		local btn2
		local i = 1

		local function back( event )
			showInter( )
            loadInter( )
  			composer.gotoScene( "scripts.cenas.3tracks.menu", {effect = "fade",time = 300} )
  			btn3:removeEventListener( "tap", back )
  			timer.cancel( timerMenu )
  			display.remove( btn )
  			composer.removeScene( scene )
		end

		local function retry( event )
			
  			composer.gotoScene( params.retry, {effect = "fade",time = 300,params={tabela=params.tabela,mode=params.mode}} )
  			btn2:removeEventListener( "tap", retry )
  			timer.cancel( timerMenu )
  			display.remove( btn2 )
  			composer.removeScene( scene )
		end

		local function stats( event )
			
  			composer.gotoScene( "scripts.cenas.3tracks.stats", {effect = "fade",time = 300,params={tabela=params.tabela,mode=params.mode,origem="result"}} )
  			btn:removeEventListener( "tap", stats )
  			timer.cancel( timerMenu )
  			display.remove( btn3 )
  			composer.removeScene( scene )
		end

		local function criarMenu (event)
			if i == 1 then
				if(carregado == true) then
					btn = Botao.newPlayButton(SSTATS,display.contentHeight / 25 * 14.2)
					btn:addEventListener( "tap", stats )
					grupoMenu:insert( btn )
				end
			elseif i == 2 then
				btn2 = Botao.newPlayButton(SRETRY,display.contentHeight / 25 * 16.5)
				btn2:addEventListener( "tap", retry )
				grupoMenu:insert( btn2 )
			elseif i == 3 then
				btn3 = Botao.newPlayButton(SBACK,display.contentHeight / 25 * 18.8)
				btn3:addEventListener( "tap", back )
				grupoMenu:insert( btn3 )
			end
			i = i + 1
		end
		timerMenu = timer.performWithDelay( 50, criarMenu ,3 )	
	end
end


-- Called when scene is about to move offscreen:
function scene:hide( event )
	local group = self.view
	display.remove(grupoMenu)
	
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