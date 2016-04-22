Snake = {}

function Snake:new(length)
	local snake = display.newGroup()
	snake.img = display.newImageRect("images/snake_" .. length ..  ".png", 6 * _W * .075 * .5, 4 * _H * .075 * .5)
	snake.whichBucket = ""
	snake:rotate(-90)
	snake:insert(snake.img)
	return snake
end
