local gameNetwork = require( "gameNetwork" )
local widget = require("widget")

globalGoogleScore = 5

gameNetwork.init("google")

function loginGooglePlay()
   local function loginCallBack( event1 )
   		if event1.isError then
			print( "erro" )
		else
			--loginLogoutButton:setLabel("Logout")
		end
   end
   print( "loginGooglePlay" )
   gameNetwork.request("login",{userInitiated = true, listener = loadHighScore})
end

function loginGooglePlayCallback( event )
	--gameNetwork.request("loadLocalPlayer", {listener = loadPlayer})

	return true
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
end

function loadHighScore(  )
	gameNetwork.request("loadScores", 
	{
		leaderboard = 
		{
			category="CgkIi7_A79oJEAIQBQ", 
			playerScope = "Global",
			timeScope = "Today",
			range = { 1,2 },
            playerCentered = true
		},
		listener = showHighScore
	})
end

function loadPlayer( event )
	--globalGoogleScore = event.data.alias
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




