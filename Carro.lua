local _W = display.contentWidth
local _H = display.contentHeight

function new( x,y )
	local carro = display.newImage( "img/carro.png", _W / 16 * x - 1, _H / 25 * y - 1);
	local carroShape = {-10,-65, 10,-65, -10,-30, 10,-30, -45,-30, 45,-30, -45,65, 45,65}
	physics.addBody( carro , "static", {isSensor = true, shape=carroShape})
	carro.type = "carro"
	carro.anchorX = 0
	carro.anchorY = 0

	function onTouch(event)
		if(event.phase == "began") then
			if event.x < _W / 2 then
				x = x - 3
				print( "funciona esquerda" )
				transition.moveTo( carro, {x = _W / 16 * x - 1, y = carro.y, time = 50} )
			else
				x = x + 3
				print( "funciona direita" )
				transition.moveTo( carro, {x = _W / 16 * x - 1, y = carro.y, time = 50} )
			end
		end
	end
	Runtime:addEventListener( "touch", onTouch )

	return carro;
end

return {
	new = new
}
