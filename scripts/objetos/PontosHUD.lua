--local Google = require("scripts.util.Google")
local gameNetwork = require( "gameNetwork" )
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
		pontosDif.text = pontos.text - (globalGoogleScore)
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

return{
	new = new
}