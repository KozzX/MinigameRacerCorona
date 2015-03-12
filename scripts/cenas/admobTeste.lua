local ads = require( "ads" )
local unitId = "ca-app-pub-9005728002485631/7063450705"

ads.init( "admob", unitId )

function tapListener( event )
	print( "tapped" )
	ads.show( "interstitial", { appId=unitId } )
end
Runtime:addEventListener( "tap", tapListener )

local carro = display.newImage( "images/carro.png", display.contentCenterX, display.contentCenterY )