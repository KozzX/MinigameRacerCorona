local gameNetwork = require( "gameNetwork" )
local widget = require("widget")
logado = false
globalGoogleScore = 5
playerName = ""

function gameNetworkSetup()
   if ( system.getInfo("platformName") == "Android" ) then
      gameNetwork.init( "google", loginGooglePlay )
   else
      gameNetwork.init( "gamecenter", gameNetworkLoginCallback )
   end
end

function loginGooglePlay(event)
   gameNetwork.request( "login", { userInitiated=true, listener=loginGooglePlayCallback } )
end

function loginGooglePlayCallback( event )
	gameNetwork.request( "loadLocalPlayer", { listener=loadPlayer } )
    return true
end

function playerConnected()
	return gameNetwork.request("isConnected")
end

function showLeaderboards()
   print( "showLeaderboards" )
   gameNetwork.show("leaderboards") 
end

function showAchievements()
   print( "showAchievements" )
   gameNetwork.show("achievements")
end

function showHighScore( event )
	globalGoogleScore = event.data[1].value / 1000
	logado = true
end

function loadHighScore( leaderboard )
	gameNetwork.request("loadScores", 
	{
		leaderboard = 
		{
			category=leaderboard, 
			playerScope = "Global",
			timeScope = "AllTime",
			range = { 1,2 },
            playerCentered = true
		},
		listener = showHighScore
	})
	return true
end

function loadPlayer( event )
	playerName = event.data.alias
	loadHighScore("CgkIi7_A79oJEAIQBQ")
end

function logoutGooglePlay()
   print( "logoutGooglePlay" )
   if (gameNetwork.request("isConnected")) then
      gameNetwork.request("logout")
   end
end

function submitHighScore( leaderboard, pontos )	
	gameNetwork.request( "setHighScore",{localPlayerScore = { category=leaderboard, value=pontos }})
end




