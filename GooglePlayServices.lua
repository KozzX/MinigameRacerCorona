--------------------------------------------------------------------
-- Este código ainda não está funcionando. 
-- Foi criada a classe mas ainda não está implementada corretamente
--------------------------------------------------------------------
local gameNetwork = require("gameNetwork")

function login ()
	gameNetwork.request("login",
			{
				listener = loginListener,
				userInitiated = true
			})
	return true
end

function something()
	print( "Something!" )
	return true
end

function nothing()
	print( "Nothing!" )
	return true
end

return{
	something = something;
	nothing = nothing;
	login = login; 
}

