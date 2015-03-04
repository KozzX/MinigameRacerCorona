local gameNetwork = require( "gameNetwork" )
local googleInfo = require( "scripts.util.googleInfo" )
local widget = require("widget")
logado = false
local ids = {}
local playerName = {}
local idName = {}
local score = {}
local rank = {}
globalGoogleScore = 5

--player = {id,nome,rank,score}

function gameNetworkSetup()
   if ( system.getInfo("platformName") == "Android" ) then
      gameNetwork.init( "google", loginGooglePlay )
   else
      gameNetwork.init( "gamecenter", gameNetworkLoginCallback )
   end
end

function loginGooglePlay(event)
   gameNetwork.request( "login", { userInitiated=true, listener=loadHighScore } )
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
	logado = true
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
			range = { 1,30 },
            playerCentered = true
		},
		listener = showHighScore
	})
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


