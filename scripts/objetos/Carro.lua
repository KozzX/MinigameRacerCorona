local Posicionamento = require( "scripts.util.posicionamento" )

local telaX = display.contentWidth
local telaY = display.contentHeight

local function new( x,y )
	local carro = display.newImage( "images/carro.png", posX(x), posY(y))
	carro.anchorX = 0
	carro.anchorY = 0

	carro.width = tamX(3)
	carro.height = tamY(4)

	return carro
end


function newCarro( x,y )
	local carro = new(x,y)
	local carroShape = {-10,-65, 10,-65, -10,-30, 10,-30, -40,-30, 40,-30, -40,65, 40,65}
	physics.addBody( carro , "static", {isSensor = true, shape=carroShape})
	carro.type = "carro"

	function onTouch(event)
		if(event.phase == "began") then
			if (event.x < telaX / 2) and (x >= 3) then
				x = x - 3
				transition.moveTo( carro, {x = posX(x), y = carro.y, time = 50} )
			elseif (event.x > telaX / 2) and (x <= 10) then
				x = x + 3
				transition.moveTo( carro, {x = posX(x), y = carro.y, time = 50} )
			end
		end
	end
	Runtime:addEventListener( "touch", onTouch )

	return carro;
end

function newObstaculo( x )
	if x == 1 then
		x = 2
	elseif x == 2 then
		x = 5
	elseif x == 3 then
		x = 8
	elseif x == 4 then
		x = 11
	end 
	local obstaculo = new(x,-5)
	local obstaculoShape = {-10,-65, 10,-65, -10,-30, 10,-30, -40,-30, 40,-30, -40,65, 40,65}
	physics.addBody( obstaculo, "dynamic", {isSensor = true, shape=obstaculoShape})
	obstaculo.type = "obstaculo"
	transition.moveTo( obstaculo, {x = obstaculo.x, y=posY(25), time = 1200, onComplete=removeObstaculo} )

	function removeObstaculo(  )
		--obstaculo:removeSelf( )
		--obstaculo = nil
	end

	return obstaculo

end

return {
	newCarro = newCarro,
	newObstaculo = newObstaculo
}
