Animal = {}

function Animal:new(file, w, h, fontsize)
	local animal = display.newGroup()
	animal.name = "animal"
	animal.ball = display.newImageRect(file, w, h)
	animal.outline = display.newImageRect("highlight.png", w, h)
	animal.outline:setFillColor(0,0,0)
	animal.outline.rotation = math.random(360)
	animal.outline.alpha = 0
	animal.text = display.newText("", 0, 0, font, fontsize)
	animal.num = 0
	animal.matched = false
	animal:insert( animal.outline )
	return animal
end
