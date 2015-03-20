local sqlite3 = require( "sqlite3" )

-- Open "data.db". If the file doesn't exist, it will be created
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )   

-- Handle the "applicationExit" event to close the database
local function onSystemEvent( event )
    if ( event.type == "applicationExit" ) then              
        db:close()
    end
end

-- Set up the table if it doesn't exist
local tablesetup = [[CREATE TABLE IF NOT EXISTS SCORE (ID INTEGER PRIMARY KEY, PLAYERNAME, GAMEMODE, HIGHSCORE, LASTSCORE, TOTALSCORE, TIMESPLAYED);]]
print( tablesetup )
db:exec( tablesetup )

-- Add rows with an auto index in 'id'. You don't need to specify a set of values because we're populating all of them.
function atualizarPontos( vGameMode, vScore)
	local vHighScore = 0
	for row in db:nrows([[SELECT * FROM score WHERE gameMode=']] .. vGameMode .. [[';]]) do
		text = row.id .. " " .. row.gameMode .. " " .. row.highScore .. " " .. row.totalScore
		vHighScore = row.highScore
	end
	
	if (vHighScore < vScore) then
		vHighScore = vScore		
	end

	if (text == nil) then
		print( "é nil" )	
		local tablefill = [[INSERT INTO score VALUES (NULL, ']] .. vGameMode .. [[',]] .. vHighScore .. [[,]] .. vHighScore .. [[);]]
		db:exec(tablefill)
	else
		local tableupdate = [[UPDATE score SET highScore=]] .. vHighScore .. [[,totalScore=totalScore+]] .. vScore .. [[ WHERE gameMode=']] .. vGameMode .. [[';]]
		db:exec(tableupdate)
		print( tableupdate )
	end
end

function dropTable()
	local tablesetup = [[DROP TABLE score;]]
	db:exec( tablesetup )	
end


-- Setup the event listener to catch "applicationExit"
Runtime:addEventListener( "system", onSystemEvent )

return {
	atualizarPontos = atualizarPontos,
	dropTable = dropTable
}
--[[CREATE TABLE IF NOT EXISTS score (id INTEGER PRIMARY KEY, highScore, totalScore);

Tabela - SCORE
--------------------
PLAYERID    - INTEGER
GAMEMODE    - TEXT 
HIGHSCORE   - INTEGER
LASTSCORE   - INTEGER
TOTALSCORE  - INTEGER
TIMESPLAYED - INTEGER

Tabela - PLAYER
PLAYERID    - INTEGER
PLAYERNAME  - TEXT
REMOVER_ADS - BOOLEAN
FIRSTTIME   - BOOLEAN
GOOGLEID    - INTEGER
]]