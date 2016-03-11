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
	tracks2easy="CgkIvIfq79UZEAIQAA",
  	tracks2normal="CgkIvIfq79UZEAIQAQ",
  	tracks2hard="CgkIvIfq79UZEAIQAg",
  	tracks2insane="CgkIvIfq79UZEAIQAw",
  	tracks3easy="CgkIvIfq79UZEAIQBA",
  	tracks3normal="CgkIvIfq79UZEAIQBQ",
  	tracks3hard="CgkIvIfq79UZEAIQBg",
  	tracks3insane="CgkIvIfq79UZEAIQBw",
  	tracks4easy="CgkIvIfq79UZEAIQCA",
  	tracks4normal="CgkIvIfq79UZEAIQCQ",
  	tracks4hard="CgkIvIfq79UZEAIQCg",
  	tracks4insane="CgkIvIfq79UZEAIQCw"
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


