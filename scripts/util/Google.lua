local gameNetwork = require( "gameNetwork" )
local googleInfo = require( "scripts.util.googleInfo" )
local widget = require("widget")
logado = false
carregado = false
local ids = {}
local idName = {}
local score = {}
local rank = {}


IDLEADERBOARDS = {
	tracks2easy="CgkIhaCr_6ofEAIQAA",
  	tracks2normal="CgkIhaCr_6ofEAIQAQ",
  	tracks2hard="CgkIhaCr_6ofEAIQAg",
  	tracks2insane="CgkIhaCr_6ofEAIQAw",
  	tracks3easy="CgkIhaCr_6ofEAIQBA",
  	tracks3normal="CgkIhaCr_6ofEAIQBQ",
  	tracks3hard="CgkIhaCr_6ofEAIQBg",
  	tracks3insane="CgkIhaCr_6ofEAIQBw",
  	tracks4easy="CgkIhaCr_6ofEAIQCA",
  	tracks4normal="CgkIhaCr_6ofEAIQCQ",
  	tracks4hard="CgkIhaCr_6ofEAIQCg",
  	tracks4insane="CgkIhaCr_6ofEAIQCw"
}

function gameNetworkSetup()
   if ( system.getInfo("platformName") == "Android" ) then
      gameNetwork.init( "google", loginGooglePlay )
   else
      gameNetwork.init( "gamecenter", gameNetworkLoginCallback )
   end
end

function loginGooglePlayCallback( event )
	if event.isError then 
		logado = false
		native.showAlert( "Error", "Unable to connect to Google Play Services. Please check you internet connection and try again.", { 'Ok' } )		
	else
		logado = true
	end
end

function loginGooglePlay(event)
    gameNetwork.request( "login", { userInitiated=true , listener=loginGooglePlayCallback } )
	
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
		ids[i]=event.data[i].playerID
		rank[i]=event.data[i].rank
		score[i]=event.data[i].value-- / 1000
	end
	gameNetwork.request("loadPlayers",
	{
		playerIDs = ids,
		listener = loadPlayerData
	})
end


function loadHighScore( event )
	gameNetwork.request("loadScores", 
	{
		leaderboard = 
		{
			category=event.data.category, 
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
	--native.showAlert( "main", message [, { buttonLabels  [, listener]}, ] )
	if(getMainPlayer()==nil) then
		carregado = false
	else
		carregado = true
	end
end

function logoutGooglePlay()
   print( "logoutGooglePlay" )
   if (gameNetwork.request("isConnected")) then
      gameNetwork.request("logout")
   end
end
--function scoreCallback (event)
--	if(event.data.category)
--end

function submitLoadScore( leaderboard, pontos )	
	gameNetwork.request( "setHighScore",{localPlayerScore = { category=leaderboard, value=pontos },listener=loadHighScore})
end

function submitScore( leaderboard, pontos )	
	gameNetwork.request( "setHighScore",{localPlayerScore = { category=leaderboard, value=pontos }})
end

function showLeaderboards()
	gameNetwork.show("leaderboards") -- Shows all the leaderboards.
end

function showAchievements()
	gameNetwork.show("achievements") -- Shows the locked and unlocked achievements.
end


