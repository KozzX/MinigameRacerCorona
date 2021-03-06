-- This function gets called when the player opens a notification or one is received when the app is open and active.
function DidReceiveRemoteNotification(message, additionalData, isActive)
    print("DidReceiveRemoteNotification:Messsage: " .. message)
    if (additionalData) then
        if (additionalData.discount) then
            native.showAlert( "Discount!", message, { "OK" } )
            -- Take player to your game store
        elseif(additionalData.bonusCredits) then
            native.showAlert( "Bonus Credits!", message, { "OK" } )
            -- Add credits and take player your game store or inventory if you like
        elseif(additionalData.actionSelected) then -- Interactive notification button pressed
            native.showAlert("Button Pressed!", "ButtonID:" .. additionalData.actionSelected, { "OK"} )
        end
    end
end

local GameThrive = require("plugin.GameThrivePushNotifications")
GameThrive.Init("3eaf1606-de16-4b6e-bb58-ede8c6923f7e", "882044994492", DidReceiveRemoteNotification)


local composer = require "composer"
local Database = require "scripts.util.Database"
local string = require( "scripts.util.string" )
local Admob = require( "scripts.util.Admob" )

native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )


propaganda = true

init()

composer.gotoScene( "scripts.cenas.loading" )