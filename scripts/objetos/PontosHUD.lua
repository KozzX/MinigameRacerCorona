local gameNetwork = require( "gameNetwork" )
local googleInfo = require( "scripts.util.googleInfo" )
local mudou = false

local textConfig = 
{
    text = 0,     
    fontSize = 40
}


function newPontosNome(  )

	local pontosNome = display.newText( textConfig )
	pontosNome.anchorX = 0
	pontosNome.anchorY = 0
	pontosNome.x = posX(2)
	pontosNome.y = posY(2)
	if logado == true then
		local nome = getPlayerByIndex(getMainPlayer()).nome
		local cont = 0
		for i in string.gmatch(nome, "%S+") do
			if cont == 0 then
				nome = i
			end
			cont = 1
		end
		pontosNome.text = getPlayerByIndex(getMainPlayer()).rank .. ") " .. nome		
	else
		pontosNome.text = "Você"
	end
	pontosNome:setFillColor( 0, 0, 0 )

	return pontosNome
end

function newPontos( )

	local pontos = display.newText( textConfig )
	pontos.anchorX = 0
	pontos.anchorY = 0
	pontos.x = posX(10)
	pontos.y = posY(2)
	pontos:setFillColor( 0.7, 0, 0 )

	return pontos
end

function newPontosDifNome( )

	local pontosDifNome = display.newText( textConfig )
	pontosDifNome.anchorX = 0
	pontosDifNome.anchorY = 0
	pontosDifNome.x = posX(2)
	pontosDifNome.y = posY(0)
	if(logado == true) then
		local nome = getPlayerByIndex(getMainPlayer()-1).nome
		local cont = 0
		for i in string.gmatch(nome, "%S+") do
			if cont == 0 then
				nome = i
			end
			cont = 1
		end
		pontosDifNome.text = getPlayerByIndex(getMainPlayer()-1).rank .. ") " .. nome
	else
		pontosDifNome.text = "Melhor"
	end
	pontosDifNome:setFillColor( 0, 0, 0 )

	return pontosDifNome
end

function newPontosDif( )

	local pontosDif = display.newText( textConfig )
	pontosDif.anchorX = 0
	pontosDif.anchorY = 0
	pontosDif.x = posX(9)
	pontosDif.y = posY(0)
	pontosDif:setFillColor( 0.7, 0, 0 )

	return pontosDif
end

function newPlayerList(  )
	local players = {}

	local textPlayer = 
	{
	    text = "player",     
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
	newPontos = newPontos,
	newPontosNome = newPontosNome,
	newPontosDif = newPontosDif,
	newPontosDifNome = newPontosDifNome,
	newPlayerList = newPlayerList
}