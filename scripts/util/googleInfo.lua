local idPlayer = {}
local nomePlayer = {}
local rankPlayer = {}
local scorePlayer = {}
local player = {}

function setPlayer( index,ids,nomes,ranks,scores )
	idPlayer[index] = ids
	nomePlayer[index] = nomes
	rankPlayer[index] = ranks
	scorePlayer[index] = scores
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