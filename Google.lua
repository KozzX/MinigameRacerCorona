local gameNetwork = require( "gameNetwork" )
local widget = require("widget")

gameNetwork.init("google")

function loginGooglePlay()
   print( "loginGooglePlay" )
   gameNetwork.request("login",{userInitiated = true})
end

function showLeaderboards()
   print( "showLeaderboards" )
   gameNetwork.show("leaderboards") 
end

function showAchievements()
   print( "showAchievements" )
   gameNetwork.show("achievements")
end

function logoutGooglePlay()
   print( "logoutGooglePlay" )
   if (gameNetwork.request("isConnected")) then
      gameNetwork.request("logout")
   end
end


