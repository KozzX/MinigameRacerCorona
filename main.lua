local composer = require "composer"
--local Admob = require( "scripts.util.Admob" )
--local store = require( "plugin.google.iap.v3" )

local propaganda = false

if (propaganda ==true) then
	init( )
end

composer.gotoScene( "scripts.cenas.loading" )