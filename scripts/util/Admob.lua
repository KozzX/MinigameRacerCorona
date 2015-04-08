local ads = require( "ads" )
local interId = "ca-app-pub-9005728002485631/7063450705"
local bannerId = "ca-app-pub-9005728002485631/5785840701"

function init(  )
	if(propaganda==true) then
		ads.init( "admob", interId)
	end
end

function loadInter( )
	if(propaganda==true) then
		ads.load("interstitial", { appId = interId})
	end
end


function showInter()
	if(propaganda==true) then
		ads.show( "interstitial", { appId=interId } )	
	end
end

function showBanner( )
	if(propaganda==true) then
		ads.show( "banner", {x=0, y=display.contentHeight-66, appId=bannerId} )
	end
end

function hideBanner( )
	ads.hide()
end