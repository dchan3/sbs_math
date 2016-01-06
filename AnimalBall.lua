AnimalBall = {}

function AnimalBall:new(x,y,r,i) 
	local ball = display.newGroup()
	ball.ball = display.newCircle( 0, 0, r )
	ball.ball:setFillColor(Blue.R, Blue.G, Blue.B)
	ball.text = display.newText(i, 0, 0, native.systemFont, ballR*.8 )
    ball.num = i
	return ball
end