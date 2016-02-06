-- reference: https://coronalabs.com/blog/2015/04/14/tutorial-the-basic-game-template/

-- menu.lua

local composer = require( "composer" )
local scene = composer.newScene()

local widget = require "widget"

--------------------------------------------

local lesson1Btn
local lesson2Btn

-- 'onRelease' event listener for lesson1Btn
local function onPlayBtnRelease()
	
	-- go to kCount_01 scene
	composer.gotoScene( "lessons.kCount_01", "fade", 500 )
	
	return true	-- indicates successful touch
end

-- 'onRelease' event listener for lesson2Btn
local function onPlayBtnRelease2()
	
	-- go to kCount_02 scene
	composer.gotoScene( "lessons.kCount_02", "fade", 500 )
	
	return true	-- indicates successful touch
end

function scene:create( event )
	local sceneGroup = self.view

	-- display a background image
	local background = display.newImageRect( "images/testBackground.png", 
            display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	
	-- create logo/title image (currently cat)
	local titleLogo = display.newImageRect( "images/cat.png", 220, 220 )
	titleLogo.x = display.contentWidth * 0.5
	titleLogo.y = 100
	
	-- create a widget button (which will loads kCount_01.lua on release)
	lesson1Btn = widget.newButton{
		label="Lesson 1",
		labelColor = { default={0}, over={128} },
                labelYOffset = 80,
                font = font,
                fontSize = 80,
		defaultFile="images/bunny.png",
		overFile="images/puppy.png",
		width=200, height=200,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	lesson1Btn.x = display.contentWidth*0.5
	lesson1Btn.y = display.contentHeight - 400
        
        -- create a widget button (which will loads kCount_02.lua on release)
	lesson2Btn = widget.newButton{
		label="Lesson 2",
		labelColor = { default={0}, over={128} },
                labelYOffset = 80,
                font = font,
                fontSize = 80,
		defaultFile="images/dog.png",
		overFile="images/tenDogs.png",
		width=200, height=200,
		onRelease = onPlayBtnRelease2	-- event listener function
	}
	lesson2Btn.x = display.contentWidth*0.5
	lesson2Btn.y = display.contentHeight - 150
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( lesson1Btn )
        sceneGroup:insert( lesson2Btn )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if lesson1Btn then
		lesson1Btn:removeSelf()	-- widgets must be manually removed
		lesson1Btn = nil
	end
        
        if lesson2Btn then
		lesson2Btn:removeSelf()	-- widgets must be manually removed
		lesson2Btn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene

