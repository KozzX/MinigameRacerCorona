local ads = require( "ads" )
local interId = "ca-app-pub-9005728002485631/7063450705"
local bannerId = "ca-app-pub-9005728002485631/5785840701"

function init(  )
	ads.init( "admob", interId)
end

function loadInter( )
	ads.load("interstitial", { appId = interId})
end


function showInter()
	print( "interstitial" )
	ads.show( "interstitial", { appId=interId } )	
end

function showBanner( )
	print( "banner" )
	ads.show( "banner", {x=0, y=display.contentHeight-60, appId=bannerId} )
end

function hideBanner( )
	print( "hide" )
	ads.hide()
end