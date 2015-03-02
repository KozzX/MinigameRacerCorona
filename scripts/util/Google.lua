local gameNetwork = require( "gameNetwork" )
local widget = require("widget")
logado = false
ids = {}
playerName = {}
scores = {}
rank = {}
globalGoogleScore = 5
playerName = ""

player = {id,nome,rank,score}

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
	playerName = 
	{
		event.data[1].alias,
		event.data[2].alias,
		event.data[3].alias,
		event.data[4].alias,
		event.data[5].alias
	}
	--native.showAlert( "Leaderboard", event.data[1].alias..rank[1]..event.data[2].alias..rank[2]..event.data[3].alias..rank[3]..event.data[4].alias..rank[4]..event.data[5].alias..rank[5], { "Ok" } )
	--native.showAlert( "Leaderboard", playerName[1]..playerName[2]..playerName[3]..playerName[4]..playerName[5], { "Ok" } )
	--native.showAlert( "Leaderboard", playerName[1], { "Ok" } )
	logado = true
end

function showHighScore( event )

	player = 
	{
		{
			id=event.data[1].playerID,
			nome="",
			rank=event.data[1].rank,
			score=event.data[1].value / 1000
		}
	},
	{
		{
			id=event.data[2].playerID,
			nome="",
			rank=event.data[2].rank,
			score=event.data[2].value / 1000
		}
	},
	{
		{
			id=event.data[3].playerID,
			nome="",
			rank=event.data[3].rank,
			score=event.data[3].value / 1000
		}
	},
	{
		{
			id=event.data[4].playerID,
			nome="",
			rank=event.data[4].rank,
			score=event.data[4].value / 1000
		}
	},
	{
		{
			id=event.data[5].playerID,
			nome="",
			rank=event.data[5].rank,
			score=event.data[5].value / 1000
		}
	}

	native.showAlert( "Leaderboard", player[1].id..player[2].id..player[3].id..player[4]..player[5].id, { "Ok" } )

	
	gameNetwork.request("loadPlayers",
	{
		playerIDs = player.id,
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


