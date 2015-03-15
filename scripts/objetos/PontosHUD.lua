local gameNetwork = require( "gameNetwork" )
local googleInfo = require( "scripts.util.googleInfo" )
local mudou = false

local textNome = 
{
    text = 0,     
    fontSize = 30,
    width = display.contentWidth,
    font="Bitwise",
    align = "left"
}
local textPontos = 
{
    text = 0,     
    fontSize = 30,
    width = display.contentWidth,
    font="Bitwise",
    align = "right"
}


function newPontosNome(  )

	local pontosNome = display.newText( textNome )
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

	local pontos = display.newText( textPontos )
	pontos.anchorX = 1
	pontos.anchorY = 0
	pontos.x = posX(14)
	pontos.y = posY(2)
	pontos:setFillColor( 0.7, 0, 0 )

	return pontos
end

function newPontosDifNome( )

	local pontosDifNome = display.newText( textNome )
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

	local pontosDif = display.newText( textPontos )
	pontosDif.anchorX = 1
	pontosDif.anchorY = 0
	pontosDif.x = posX(14)
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
		player = display.newText( textPontos )
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