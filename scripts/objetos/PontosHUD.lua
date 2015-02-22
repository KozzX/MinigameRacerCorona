function new(  )
	local textPontos = 
	{
	    text = 0,     
	    --x = display.contentCenterX,
	    --y = display.contentCenterY/25 * 2,
	    font = native.newFont( "8bit16", 50 ),
	    fontSize = 50 
	}

	local pontos = display.newText( textPontos )
	pontos.anchorX = 0
	pontos.anchorY = 0
	pontos.x = posX(5)
	pontos:setFillColor( 0, 0, 0 )

	function enterFrameListener( event )
		pontos.text = pontos.text + (0.016);
		pontos:toFront( )
	end
	Runtime:addEventListener("enterFrame",enterFrameListener)

	function pontos:mudarCor()
		local pt = tonumber(pontos.text)
		if(pt >= 10) then
			pontos:setFillColor( 0, 0.5, 0 )
		else
			pontos:setFillColor( 0.7, 0, 0 )
		end
	end


	return pontos
end

return{
	new = new
}