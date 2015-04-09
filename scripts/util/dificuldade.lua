function getLevel( mode )
	local level = {speed, target, speedLimit, targetLimit}
	if mode == "2TRACKS-EASY" then
		level.speed = 2000
		level.target = 100
		level.speedLimit = 1500
		level.targetLimit = 26
	elseif mode == "2TRACKS-NORMAL" then
		level.speed = 1800
		level.target = 80
		level.speedLimit = 1250
		level.targetLimit = 25
	elseif mode == "2TRACKS-HARD" then
		level.speed = 1500
		level.target = 60
		level.speedLimit = 1000
		level.targetLimit = 21
	elseif mode == "2TRACKS-INSANE" then
		level.speed = 1200
		level.target = 35
		level.speedLimit = 900
		level.targetLimit = 19
	elseif mode == "3TRACKS-EASY" then
		level.speed = 0
		level.target = 0
		level.speedLimit = 0
		level.targetLimit = 0
	elseif mode == "3TRACKS-NORMAL" then
		level.speed = 0
		level.target = 0
		level.speedLimit = 0
		level.targetLimit = 0
	elseif mode == "3TRACKS-HARD" then
		level.speed = 0
		level.target = 0
		level.speedLimit = 0
		level.targetLimit = 0
	elseif mode == "3TRACKS-INSANE" then
		level.speed = 0
		level.target = 0
		level.speedLimit = 0
		level.targetLimit = 0
	elseif mode == "4TRACKS-EASY" then
		level.speed = 0
		level.target = 0
		level.speedLimit = 0
		level.targetLimit = 0
	elseif mode == "4TRACKS-NORMAL" then
		level.speed = 0
		level.target = 0
		level.speedLimit = 0
		level.targetLimit = 0
	elseif mode == "4TRACKS-HARD" then
		level.speed = 0
		level.target = 0
		level.speedLimit = 0
		level.targetLimit = 0
	elseif mode == "4TRACKS-INSANE" then
		level.speed = 0
		level.target = 0
		level.speedLimit = 0
		level.targetLimit = 0
	end
	return level
end