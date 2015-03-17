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
	ads.show( "interstitial", { appId=interId } )	
end

function showBanner( )
	ads.show( "banner", {x=0, y=display.contentHeight-65, appId=bannerId} )
end

function hideBanner( )
	ads.hide()
end