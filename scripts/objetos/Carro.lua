local Posicionamento = require( "scripts.util.posicionamento" )



local function new( x,y )
	local carro = display.newImage( "images/carro.png", posX(x), posY(y))
	carro.anchorX = 0
	carro.anchorY = 0

	--carro.width = tamX(3)
	--carro.height = tamY(4)

	return carro
end


function newCarro( x,y )
	local carro = new(x,y)
	local carroShape = {-10,-65, 10,-65, -10,-30, 10,-30, -40,-30, 40,-30, -40,65, 40,65}
	physics.addBody( carro , "static", {isSensor = true, shape=carroShape})
	carro.type = "carro"


	return carro;
end

function newObstaculo( x,vel,tracks )
	if(tracks == "3") then
		if (x==1) then
			x = 3	
		elseif x == 2 then
			x = 6
		elseif x == 3 then
			x = 9
		end
	else
		if x == 1 then
			x = 2
		elseif x == 2 then
			x = 5
		elseif x == 3 then
			x = 8
		elseif x == 4 then
			x = 11
		end
	end
	local obstaculo = new(x,-5)
	local obstaculoShape = {-10,-65, 10,-65, -10,-30, 10,-30, -40,-30, 40,-30, -40,65, 40,65}
	physics.addBody( obstaculo, "dynamic", {isSensor = true, shape=obstaculoShape})
	obstaculo.type = "obstaculo"
	transition.moveTo( obstaculo, {x = obstaculo.x, y=posY(25), time = vel, onComplete=removeObstaculo} )

	function removeObstaculo(  )
		display.remove(obstaculo)
		obstaculo = nil
	end

	return obstaculo

end

return {
	newCarro = newCarro,
	newObstaculo = newObstaculo
}
