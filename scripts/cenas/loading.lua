---------------------------------------------------------------------------------
--
-- loading.lua
--
---------------------------------------------------------------------------------
local Google = require("scripts.util.Google")
local Explosao = require("scripts.objetos.Explosao")
local googleInfo = require( "scripts.util.googleInfo" )
local connection = require( "scripts.util.connection" )
local composer = require( "composer" )



local scene = composer.newScene(  )
local explosao

---------------------------------------------------------------------------------

function scene:create( event )
    setLanguage(getLang())
    local sceneGroup = self.view

end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        loadInter()
        
        
    elseif phase == "did" then
        local tentativas = 0
        explosao = Explosao.newLoad(display.contentWidth / 2, display.contentHeight / 2)
        sceneGroup:insert(explosao) 
        --if(connected()) and ( system.getInfo("platformName") == "Android" )  then
        gameNetworkSetup()
        
        MUSIC = audio.loadSound( "audio/Reformat.mp3" )
        EXPLOSION = audio.loadSound( "audio/Explosion.wav" )
        POINT = audio.loadSound( "audio/Point.wav" )
        POINTPASS = audio.loadSound( "audio/PointPass.wav" )
        --end
        --http://forums.coronalabs.com/topic/33356-check-for-internet-connection/

        
        function start( event )
            if(logado==true) then
                composer.gotoScene( "scripts.cenas.mainmenu",{ effect = "fade", time = 300 } )
                timer.cancel( timerstart )
            end
            if (logado ~= true) and (tentativas >= 3) then
                logado = false
                composer.gotoScene( "scripts.cenas.mainmenu",{ effect = "fade", time = 300 } )
                timer.cancel( timerstart )
            end
            tentativas = tentativas + 1
        end
        timerstart = timer.performWithDelay( 1000, start, -1 )

    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
    elseif phase == "did" then
        -- Called when the scene is now off screen
        explosao:removeSelf( )
        explosao = nil
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
