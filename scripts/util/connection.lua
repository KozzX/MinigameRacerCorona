local socket = require("socket")

function connected()
            
	local test = socket.tcp()
	test:settimeout(1000)                   -- Set timeout to 1 second
            	
	local testResult = test:connect("play.google.com", 80)        -- Note that the test does not work if we put http:// in front
	 
	if not(testResult == nil) then
		print( "Conectado" )
		return true
	else
		print( "Não conectado" )
	    return false
	end     	
	test:close()
	test = nil
end