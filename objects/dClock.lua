local numInput = require ("objects.numInput")
dClock = {}

function dClock:new(x,y)
	local clock = display.newGroup()
	clock.img = display.newImage("images/digi_clock.png", x, y)
	clock.hourWidget = numInput:new(1, x, y)
	return clock
end
