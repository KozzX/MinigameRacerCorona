local _W = display.contentWidth
local _H = display.contentHeight

function new( x )
	local obstaculo = display.newImage( "img/carro.png", _W / 16 * x -1 , -(_H / 25 * 5))
	local obstaculoShape = {-10,-65, 10,-65, -10,-30, 10,-30, -40,-30, 40,-30, -40,65, 40,65}
	physics.addBody( obstaculo, "dynamic", {isSensor = true, shape=obstaculoShape})
	obstaculo.type = "obstaculo"
	obstaculo.anchorX = 0
	obstaculo.anchorY = 0
	--obstaculo:scale( 0.9, 1 )
	transition.moveTo( obstaculo, {x = obstaculo.x, y=_H/25 * 25 -1, time = 2000, onComplete=removeObstaculo } )

	function removeObstaculo(  )
		obstaculo:removeSelf( )
	end

end
return {
	new = new
}