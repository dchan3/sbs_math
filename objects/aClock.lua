aClock = {}

function aClock:new(x,y, time, movable)
	local function distBetween( x1, y1, x2, y2 )
			return math.sqrt( math.pow((x2 - x1),2) + math.pow((y2 - y1),2) )
	end

	local function angleBetween( srcX, srcY, dstX, dstY )
		return ( math.deg( math.atan2( dstY-srcY, dstX-srcX ) )+90 ) % 360
	end

	local clock = display.newGroup()
	clock.x, clock.y = x,y
	clock.padX, clock.padY = x, y
	clock.bgImg = display.newImage("images/clock.png", x, y);

		clock.controlPad2 = display.newCircle( clock.padX,clock.padY, 160 )
		clock.controlPad2:setFillColor(1,0,0)
		clock.controlPad2.x, clock.controlPad2.y = clock.padX, clock.padY
		clock.controlPad2.alpha = 0.5

	clock.controlPad = display.newCircle( clock.padX,clock.padY, 80 )
	clock.controlPad.x, clock.controlPad.y = clock.padX, clock.padY
	clock.controlPad:setFillColor(0,1,0)
	clock.controlPad.alpha = 0.5

	clock.shorthand = display.newLine(clock.x, clock.y, clock.x, clock.y - 80)
	clock.shorthand:setStrokeColor(0,0,0)
	clock.shorthand.strokeWidth = 8
	clock.shorthand.anchorX = 0

	clock.longhand = display.newLine(clock.x, clock.y, clock.x, clock.y - 100)
	clock.longhand:setStrokeColor(0,0,0)
	clock.longhand.strokeWidth = 8
	clock.longhand.anchorX = 0


	local function padTouched(self, event)
			print(self.path.radius)
			if self.path.radius == 80 then
				clock.shorthand.rotation = angleBetween(self.x, self.y, event.x, event.y)
			end
			if self.path.radius == 160 then
				clock.longhand.rotation = angleBetween(self.x, self.y, event.x, event.y)
			end

			if(event.phase == "began") then
			elseif (event.phase == "moved" ) then
				print(angleBetween(self.x, self.y, event.x, event.y))
			elseif(event.phase == "ended" ) then

			end
			return true
	end


	clock.controlPad2.touch = padTouched
	clock.controlPad2:addEventListener("touch", clock.controlPad2)

	clock.controlPad.touch = padTouched
	clock.controlPad:addEventListener("touch", clock.controlPad)


	return clock
end
