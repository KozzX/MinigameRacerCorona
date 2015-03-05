local idPlayer = {}
local nomePlayer = {}
local rankPlayer = {}
local scorePlayer = {}
local player = {}
local mainPlayer = {id,nome,score}

function setPlayer( index,ids,nomes,ranks,scores )
	idPlayer[index] = ids
	nomePlayer[index] = nomes
	rankPlayer[index] = ranks
	scorePlayer[index] = scores
end

function setMainPlayer( ids,nomes )
	mainPlayer.id = ids
	mainPlayer.nome = nomes

	for i=1,tamanho() do
		if mainPlayer.id == idPlayer[i] then
			mainPlayer.score = scorePlayer[i]
		end
	end
	native.showAlert( "LocalPlayer", mainPlayer.score, {"Ok"} )
end

function getPlayerByIndex( index )
	player = 
	{
		id=idPlayer[index],
		nome=nomePlayer[index],
		rank=rankPlayer[index],
		score=scorePlayer[index]
	}
	return player
end

function tamanho()
	return #idPlayer
end