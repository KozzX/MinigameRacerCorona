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
		level.speed = 2000
		level.target = 100
		level.speedLimit = 1100
		level.targetLimit = 33
	elseif mode == "3TRACKS-NORMAL" then
		level.speed = 1600
		level.target = 70
		level.speedLimit = 1100
		level.targetLimit = 33
	elseif mode == "3TRACKS-HARD" then
		level.speed = 1400
		level.target = 55
		level.speedLimit = 1100
		level.targetLimit = 33
	elseif mode == "3TRACKS-INSANE" then
		level.speed = 1300
		level.target = 50
		level.speedLimit = 1100
		level.targetLimit = 30
	elseif mode == "4TRACKS-EASY" then
		level.speed = 2200
		level.target = 100
		level.speedLimit = 1200
		level.targetLimit = 39
	elseif mode == "4TRACKS-NORMAL" then
		level.speed = 1900
		level.target = 90
		level.speedLimit = 1200
		level.targetLimit = 39
	elseif mode == "4TRACKS-HARD" then
		level.speed = 1400
		level.target = 50
		level.speedLimit = 1200
		level.targetLimit = 39
	elseif mode == "4TRACKS-INSANE" then
		level.speed = 1300
		level.target = 45
		level.speedLimit = 1200
		level.targetLimit = 37
	end
	return level
end