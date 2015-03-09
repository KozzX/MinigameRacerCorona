local gameNetwork = require( "gameNetwork" )
local googleInfo = require( "scripts.util.googleInfo" )
local mudou = false



function new(  )
	local textPontos = 
	{
	    text = 0,     
	    font = native.newFont( "8_bit_1_6", 50 ),
	    fontSize = 50 
	}

	local pontos = display.newText( textPontos )
	pontos.anchorX = 0
	pontos.anchorY = 0
	--pontos.font = ""
	pontos.x = posX(2)
	pontos:setFillColor( 0.7, 0, 0 )

	local textDif = 
	{
	    text = 0,     
	    font = native.newFont( "8_bit_1_6", 50 ),
	    fontSize = 50 
	}

	local pontosDif = display.newText( textDif )
	pontosDif.anchorX = 0
	pontosDif.anchorY = 0
	pontosDif.x = posX(10)
	pontosDif:setFillColor( 0.7, 0, 0 )

	function enterFrameListener( event )
		pontos.text = pontos.text + (0.016);
		pontosDif.text = pontos.text - (getPlayerByIndex(getMainPlayer()-1).score )
		pontos:toFront( )
		pontosDif:toFront( )
		if tonumber(pontosDif.text) >= 0  and mudou == false then
			pontos:mudarCor()
		end
	end
	Runtime:addEventListener("enterFrame",enterFrameListener)

	function pontos:mudarCor()
		pontos:setFillColor( 0, 0.5, 0 )
		pontosDif:setFillColor( 0, 0.5, 0 )
		mudou = true
	end

	function pontos:submitScore(  )
		submitHighScore("CgkIi7_A79oJEAIQBQ",(tonumber( pontos.text ) * 1000))
		--showLeaderboards()
	end

	return pontos
end

function newPlayerList(  )
	local players = {}

	local textPlayer = 
	{
	    text = "player",     
	    font = native.newFont( "8_bit_1_6", 15 ),
	    fontSize = 15

	}
	for i=1,tamanho() do
		players[i] = getPlayerByIndex(i)
		player = display.newText( textPlayer )
		if (getMainPlayer() == i) then
			player:setFillColor(0.7, 0, 0)
		else
			player:setFillColor(0,0,0)
		end
		player.alpha = 0
		transition.to( player, {time = 2000, alpha = 1} )
		player.anchorX = 0
		player.anchorY = 0
		player.y = (i-1)*15
		player.text = players[i].rank .. ") " .. players[i].nome .. " - " .. players[i].score
	end

end

return{
	new = new,
	newPlayerList = newPlayerList
}