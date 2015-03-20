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
local tablesetup = [[CREATE TABLE IF NOT EXISTS PLAYER (
						CODPLA INTEGER PRIMARY KEY, 
						NOMPLA TEXT, 
						REMOVER_ADS, 
						FIRSTTIME, 
						GOOGLEID INTEGER
					);
					CREATE TABLE IF NOT EXISTS SCORE (
						CODMOD TEXT, 
						CODPLA INTEGER, 
						HIGHSCORE INTEGER, 
						LASTSCORE INTEGER, 
						TOTALSCORE INTEGER, 
						TIMESPLAYED INTEGER,
						PRIMARY KEY (CODMOD,CODPLA)
					);]]

print( tablesetup )
db:exec( tablesetup )
function primeiroJogo( player )
	for row in db:nrows("SELECT FIRSTTIME FROM PLAYER WHERE CODPLA = " .. player) do
	    print( row.FIRSTTIME)
	    return row.FIRSTTIME
	end	
end

function submeterPontos(gameMode,player, ponto)
	local tableupdate = [[UPDATE SCORE SET LASTSCORE=]]..pontos..[[ ]]
end

function isHighScore( gameMode, player, ponto )
	for row in db:nrows("SELECT HIGHSCORE FROM SCORE WHERE CODPLA = "..player.."") do
	    return row.FIRSTTIME
	end	
end


function preencherTabelas(  )
	local tablefill = [[INSERT INTO PLAYER VALUES(1, 'Nome', 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE2-1EASY', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE2-1NORMAL', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE2-1HARD', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE2-1INSANE', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE3-1EASY', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE3-1NORMAL', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE3-1HARD', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE3-1INSANE', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE3-2EASY', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE3-2NORMAL', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE3-2HARD', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE3-2INSANE', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE4-1EASY', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE4-1NORMAL', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE4-1HARD', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE4-1INSANE', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE4-2EASY', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE4-2NORMAL', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE4-2HARD', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE4-2INSANE', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE4-3EASY', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE4-3NORMAL', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE4-3HARD', 1, 0, 0, 0, 0);
						INSERT INTO SCORE VALUES('ARCADE4-3INSANE', 1, 0, 0, 0, 0)]]
	db:exec( tablefill )
end

function buscarPontos( gameMode,player )
	local i = 0
	for row in db:nrows("SELECT S.CODMOD,S.CODPLA,P.NOMPLA FROM SCORE S,PLAYER P WHERE S.CODPLA = P.CODPLA AND S.CODMOD = " .. gameMode .. "AND S.CODPLA = " .. player) do
	    local text = row.CODMOD .. " " .. row.CODPLA .. " " .. row.NOMPLA
	    local t = display.newText( text, display.contentCenterX, i, nil, 12 )
	    t:setFillColor( 1, 0, 1 )
	    print( row.CODMOD, row.CODPLA, i)
	    i = i + 15
	end
end
buscarPontos("'ARCADE2-1EASY'",1)
primeiroJogo(1)

-- Print the table contents


local tablesetup = [[DROP TABLE SCORE; DROP TABLE PLAYER;]]
print( tablesetup )
--db:exec( tablesetup )

-- Setup the event listener to catch "applicationExit"
Runtime:addEventListener( "system", onSystemEvent )

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

					CREATE TABLE IF NOT EXISTS SCORE (
						CODMOD TEXT, 
						CODPLA INTEGER, 
						HIGHSCORE INTEGER, 
						LASTSCORE INTEGER, 
						TOTALSCORE INTEGER, 
						TIMESPLAYED INTEGER,
						PRIMARY KEY (CODMOD,CODPLA)
					);
					INSERT INTO PLAYER VALUES(1, 'Nome', false, false, 0);
					INSERT INTO SCORE VALUES('ARCADE2-1EASY', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE2-1NORMAL', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE2-1HARD', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE2-1INSANE', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE3-1EASY', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE3-1NORMAL', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE3-1HARD', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE3-1INSANE', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE3-2EASY', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE3-2NORMAL', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE3-2HARD', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE3-2INSANE', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE4-1EASY', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE4-1NORMAL', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE4-1HARD', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE4-1INSANE', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE4-2EASY', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE4-2NORMAL', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE4-2HARD', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE4-2INSANE', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE4-3EASY', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE4-3NORMAL', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE4-3HARD', 1, 0, 0, 0, 0);
					INSERT INTO SCORE VALUES('ARCADE4-3INSANE', 1, 0, 0, 0, 0);
]]