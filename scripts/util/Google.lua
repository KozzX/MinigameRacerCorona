local gameNetwork = require( "gameNetwork" )
local widget = require("widget")
logado = false
ids = {}
playerName = {}
idName = {}
score = {}
rank = {}
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
				playerName[q] = event.data[p].alias
			end
		end
	end
	logado = true
end

function showHighScore( event )

	for i=1,#event.data do
		ids[#ids+1]=event.data[i].playerID
		rank[#rank+1]=event.data[i].rank
		score[#score+1]=event.data[i].value / 1000
	end

	--native.showAlert( "Leaderboard", player[1].id..player[2].id..player[3].id..player[4]..player[5].id, { "Ok" } )

	
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
			category="CgkIi7_A79oJEAIQBQ", 
			playerScope = "Global",
			timeScope = "AllTime",
			range = { 1,5 },
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


