local widget = require( "widget" )
dClock = {}

function dClock:new(x, y, movable, hours, mins)
	local clock = display.newGroup()
	clock.img = display.newImage("images/digi_clock.png", x, y)

	clock.nums = {}
	clock.text = {}

	for i=1,4 do
		if i == 1 then
			clock.nums[i] = math.floor(hours / 10)
		end
		if i == 2 then
			clock.nums[i] = hours % 10
		end
		if i == 3 then
			clock.nums[i] = math.floor(mins / 10)
		end
		if i == 4 then
			clock.nums[i] = mins % 10
		end
		clock.text[i] = display.newText(clock.nums[i], x - 240 + 160 * (i - 1), y, font, _W * .07)
	end

	local function onStepperPress( event )
		local id = event.target.id
		for i=1,4 do
			if id == "plus" .. i then
					clock.nums[i] = clock.nums[i] + 1
			end
			if id == "minus" .. i then
					clock.nums[i] = clock.nums[i] - 1
			end
		end
		clock.text[i].text = clock.nums[i]
	end

	local function checkTime(h_tens, h_ones, m_tens, m_ones)
		if h_tens > 1 then
			h_tens = 1
		end
		if h_tens < 0 then
			h_tens = 0
		end
	end

	if movable == true then
		clock.plusButtons = {}
		for i=1,4 do
			clock.plusButtons[i] = widget.newButton{
                    id = "plus" .. i,
                    width = _W*.07,
                    height = _W*.07,
                    defaultFile="images/plus.png",
                    onPress = onStepperPress,
            }
			clock.plusButtons[i].x, clock.plusButtons[i].y = x - 240 + 160 * (i - 1), y - 180
		end
 		clock.minusButtons = {}
		for i=1,4 do
			clock.minusButtons[i] = widget.newButton{
                    id = "minus" .. i,
                    width = _W*.07,
                    height = _W*.07,
                    defaultFile="images/minus.png",
                    onPress = onStepperPress,
            }
			clock.minusButtons[i].x, clock.minusButtons[i].y = x - 240 + 160 * (i - 1), y + 180
		end
	end

	function clock.setTime( time )
		
		clock.text[1].text = time:sub( 1,1 )
		clock.text[2].text = time:sub( 2,2 )
		clock.text[3].text = time:sub( 3,3 )
		clock.text[4].text = time:sub( 4,4 )
        
    end

	return clock
end
