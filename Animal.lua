Animal = {}

function Animal:new(file, w, h, fontsize)
	local animal = display.newGroup()
	animal.name = "animal"
	animal.ball = display.newImageRect(file, w, h)
	animal.text = display.newText("", 0, 0, font, fontsize)
	animal.num = 0
	animal.matched = false
	return animal
end
