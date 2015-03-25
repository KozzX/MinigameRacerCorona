local gameNetwork = require( "gameNetwork" )
local googleInfo = require( "scripts.util.googleInfo" )
local widget = require("widget")
logado = true
carregado = false
local ids = {}
local idName = {}
local score = {}
local rank = {}

IDLEADERBOARDS = {
	tracks2easy="CgkIi7_A79oJEAIQBQ",
  	tracks2normal="CgkIi7_A79oJEAIQEw",
  	tracks2hard="CgkIi7_A79oJEAIQDA",
  	tracks2insane="CgkIi7_A79oJEAIQDQ",
  	tracks3easy="CgkIi7_A79oJEAIQDw",
  	tracks3normal="CgkIi7_A79oJEAIQEQ",
  	tracks3hard="CgkIi7_A79oJEAIQEA",
  	tracks3insane="CgkIi7_A79oJEAIQEg",
  	tracks4easy="CgkIi7_A79oJEAIQFA",
  	tracks4normal="CgkIi7_A79oJEAIQFQ",
  	tracks4hard="CgkIi7_A79oJEAIQFg",
  	tracks4insane="CgkIi7_A79oJEAIQFw"
}

function gameNetworkSetup()
   if ( system.getInfo("platformName") == "Android" ) then
      gameNetwork.init( "google", loginGooglePlay )
   else
      gameNetwork.init( "gamecenter", gameNetworkLoginCallback )
   end
end

function loginGooglePlay(event)
    gameNetwork.request( "login", { userInitiated=true , listener=loadHighScore } )
	--logado = true
end

function loginGooglePlayCallback( event )
	gameNetwork.request( "loadLocalPlayer", { listener=loadPlayer } )
    return true
end

function loadPlayerData( event )
	for p=1, #event.data do
		idName[p] = event.data[p].playerID
		for q=1, #event.data do
			if(idName[p]==ids[q]) then
				setPlayer(q,ids[q],event.data[p].alias,rank[q],score[q])
			end
		end
	end
	localPlayer()
	
end

function localPlayer( )
	gameNetwork.request ("loadLocalPlayer",{listener=loadPlayer})
end

function showHighScore( event )

	for i=1,#event.data do
		ids[#ids+1]=event.data[i].playerID
		rank[#rank+1]=event.data[i].rank
		score[#score+1]=event.data[i].value-- / 1000
	end
	gameNetwork.request("loadPlayers",
	{
		playerIDs = ids,
		listener = loadPlayerData
	})
end


function loadHighScore(  )
	gameNetwork.request("loadScores", 
	{
		leaderboard = 
		{
			category="CgkIi7_A79oJEAIQDA", 
			playerScope = "Global",
			timeScope = "AllTime",
			range = { 1,10 },
            playerCentered = true
		},
		listener = showHighScore
	})
end

function loadPlayer( event )
	setMainPlayer(event.data.playerID,event.data.alias)
	logado = true
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

function showLeaderboards()
	gameNetwork.show("leaderboards") -- Shows all the leaderboards.
end

function showAchievements()
	gameNetwork.show("achievements") -- Shows the locked and unlocked achievements.
end


