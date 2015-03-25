---------------------------------------------------------------------------------
--
-- loading.lua
--
---------------------------------------------------------------------------------
local composer = require( "composer" )


local scene = composer.newScene(  )


---------------------------------------------------------------------------------

function scene:create( event )
    local sceneGroup = self.view

end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        
        
    elseif phase == "did" then
        local tentativas = 0
        --explosao = Explosao.newLoad(display.contentWidth / 2, display.contentHeight / 2)
        --sceneGroup:insert(explosao) 
        loadHighScore(IDLEADERBOARDS.tracks2hard)
        function carregarGame (event)
            if(carregado == true) then
                composer.gotoScene( "scripts.cenas.2tracks.easy", {effect = "fade",time = 300} )
                timer.cancel( timerGame )
            end
        end
        timerGame = timer.performWithDelay( 1000, carregarGame, -1 )
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
        --explosao:removeSelf( )
        --explosao = nil
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