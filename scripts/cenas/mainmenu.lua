local composer = require( "composer" )
local scene = composer.newScene()
local Botao = require( "scripts.objetos.Botao" )
local store = require( "plugin.google.iap.v3" )



function loja( event )
	local transaction = event.transaction

    if ( transaction.state == "purchased" ) then
    	propaganda = false
    	hideBanner()
    elseif ( transaction.state == "cancelled" ) then
    	native.showAlert( "Cancelled", "User cancelled transaction", { "Ok"} )
    elseif ( transaction.state == "failed" ) then
    	native.showAlert( "Failed", transaction.errorType .. " " .. transaction.errorString, { "Ok"} )
    else
        print( "Unknown event" )
    end
    store.finishTransaction( transaction )
end
store.init( "google", loja )

store.restore( )


local grupoMenu



---------------------------------------------------------------------------------
-- SCENE EVENTS
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:create( event )
	local group = self.view
	local bg = display.newImage( "images/background.png", true)
	bg.anchorX, bg.anchorY = 0, 0
	local title1 = display.newText( "MINIGAME", display.contentCenterX, display.contentHeight / 25 * 2.5, "Bitwise", 50)
	local title2 = display.newText( "RACER", display.contentCenterX, display.contentHeight / 25 * 4, "Bitwise", 50)
	title1:setFillColor( 0,0,0 )
	title2:setFillColor( 0,0,0 )
	local table = display.newRoundedRect( display.contentCenterX,display.contentHeight / 25 * 1 ,display.contentWidth / 16 * 14, display.viewableContentHeight-100,10 )
	table.anchorY = 0
	table.stroke = {0,0,0}
	table.strokeWidth = 4
	table:setFillColor( 0.7,0.7,0.7 )
	
	group:insert( bg )
	group:insert( table )
	group:insert( title1 )
	group:insert( title2 )

end


-- Called immediately after scene has moved onscreen:
function scene:show( event )
	local group = self.view

	if event.phase == "will" then
		showBanner()		
		
	elseif event.phase == "did" then
		grupoMenu = display.newGroup( )
		local btn
		local btn2
		local btn3
		local btn4
		local btn5
		local btn6
		local i = 1
		local function play( event )
  			composer.gotoScene( "scripts.cenas.menutrack", {effect = "slideLeft",time = 300} )
  			btn:removeEventListener( "tap", play )
		end
		local function stats( event )
			composer.gotoScene( "scripts.cenas.menustatstrack", {effect = "slideLeft",time = 300} )
			btn2:removeEventListener( "tap", stats )
		end

		local function leaderboards ( event )
			showLeaderboards()
			--system.openURL("https://play.google.com/store/apps/details?id=com.andre.minigameracer") 
			--btn4:removeEventListener( "tap", leaderboards )
		end

		local function rate (event)
			system.openURL("https://play.google.com/store/apps/details?id=com.andre.minigameracer")
		end

		local function achievements ( event )
			showAchievements()
		end

		local function buy ( event )
			store.purchase("remover_ads")
			--btn3:removeEventListener( "tap", buy )
		end

		local function exit ( event )
			local function sair( event )
				if event.action == "clicked" then
        			local i = event.index
        			if i == 1 then
	            		native.requestExit()
        			elseif i == 2 then

        			end
    			end
			end
			native.showAlert( SALERT, SMSGEXIT, { SYES,SNO }, sair )
			
		end
		
		function criarMenu (event)
			if i == 1 then
				btn = Botao.newPlayButton(SPLAY,display.contentHeight / 25 * 5)
				btn:addEventListener( "tap", play )
				grupoMenu:insert( btn )
			elseif i == 2 then
				btn2 = Botao.newPlayButton(SSTATS,display.contentHeight / 25 * 7.3)
				btn2:addEventListener( "tap", stats )
				grupoMenu:insert( btn2 )
			elseif i == 3 then
				btn3 = Botao.newPlayButton(SSTORE,display.contentHeight / 25 * 9.6)
				btn3:addEventListener( "tap", buy )
				grupoMenu:insert( btn3 )
			elseif i == 4 then
				btn4 = Botao.newPlayButton(SLEADERBOARD,display.contentHeight / 25 * 11.9)
				btn4:addEventListener( "tap", leaderboards )
				grupoMenu:insert( btn4 )
			elseif i == 5 then
				btn5 = Botao.newPlayButton(SRATE,display.contentHeight / 25 * 14.2)
				btn5:addEventListener( "tap", rate )
				grupoMenu:insert( btn5 )
			elseif i == 6 then
				btn6 = Botao.newPlayButton(SEXIT,display.contentHeight / 25 * 18.8)
				btn6:addEventListener( "tap", exit )
				grupoMenu:insert( btn6 )
			end
			i = i + 1
		end
		timerMenu = timer.performWithDelay( 50, criarMenu ,6 )	
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