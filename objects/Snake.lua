Snake = {}

function Snake:new(length)
	local snake = display.newGroup()
	snake.img = display.newImageRect("images/snake_" .. length ..  ".png", 6 * _W * .075 * .5, 4 * _H * .075 * .5)
	snake.whichBucket = ""
	snake:rotate(-90)
	snake:insert(snake.img)

local function drag( event )
	local t = event.target
	
	local phase = event.phase
	if "began" == phase then
		-- Make target the top-most object
		local parent = t.parent
		parent:insert( t )
		display.getCurrentStage():setFocus( t )
		
		-- Spurious events can be sent to the target, e.g. the user presses 
		-- elsewhere on the screen and then moves the finger over the target.
		-- To prevent this, we add this flag. Only when it's true will "move"
		-- events be sent to the target.
		t.isFocus = true
		
		-- Store initial position
		t.x0 = event.x - t.x
		t.y0 = event.y - t.y
	elseif t.isFocus then
		if "moved" == phase then
			-- Make object move (we subtract t.x0,t.y0 so that moves are
			-- relative to initial grab point, rather than object "snapping").
			t.x = event.x - t.x0
			t.y = event.y - t.y0
			
			-- Gradually show the shape's stroke depending on how much pressure is applied.

		elseif "ended" == phase or "cancelled" == phase then
			display.getCurrentStage():setFocus( nil )
			t.isFocus = false
		end
	end

	-- Important to return true. This tells the system that the event
	-- should not be propagated to listeners of any objects underneath.
	return true
end

	snake:addEventListener("touch", drag)



	return snake
end
