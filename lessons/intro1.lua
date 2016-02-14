-- intro1.lua

--[[ 
    Animated tutorial scene for lesson one. Opens lesson 1 upon completion.
    Set timing of events in timers at the end of scene:create.
    Set size, position, and transition of objects in tutorial functions below 
    variable list. 
]]--

local composer = require( "composer" )
local numLine = require( "objects.numLine" )
local animal = require("objects.animal")
local animalball = require("objects.animalball")
local physics = require "physics"
physics.start()


local scene = composer.newScene()

local max = 3
local count = max

local countBalls = {}
local matchBalls = {}
local numberLine
local displayText = {}

local sceneGroup

local decText
local latText

-- variables and functions for tutorial -------------------------------------

local boardText
local hand
local board
local moveBall
local animal

-- fades chalkboard into scene
local function showBoard ( event )
    board = display.newImage( "images/small_chalkboard.png" )
    board.x = _W * .7
    board.y = _H * .25
    board:scale(.8, .8)
    board.alpha = 0
    transition.fadeIn( board, {time=500} )   
end

-- fades hand into scene
local function showHand ( event )
    hand = display.newImage( "images/hand.png" )
    hand.x = _W * .6
    hand.y = _H -50
    hand.alpha = 0
    transition.fadeIn( hand, {time=500} )
end

-- chalkboard text sequence
local function textDisplay ( event )
    boardText = display.newText( "Drag the numbers", _W*.7, 
            _H*.25, font, 40 )   
end

local function text2 ( event )
    boardText.text = "to the animals."
end

local function text3 ( event )
    boardText.text = "Good Job!"
end

local function text4 ( event )
    boardText.text = "Now YOU try!"
    boardText:setFillColor(1,0,0)
end

-- upward hand transition
local function handMoveUp( event )
    transition.to(hand, {x= _W * .25, y=_H -380, time=2000 })
end

-- downward hand and ball transitions
local function handMoveDown ( event )
    transition.to(hand, {x= _W *.4, y= _H*.8, time=1500 })
    transition.to(moveBall, {x= _W *.3, y= _H*.7, time=1500 })
end

-- fades animal when covered by number. set timing below
local function animalFade ( event )
    animal.alpha = .3
end

local function endIntro()
	
	-- removing tutorial objects
        hand:removeSelf()
        boardText:removeSelf()
        board:removeSelf()
        -- go to lesson 1
	composer.gotoScene( "lessons.kCount_01", "fade", 500 )
	
	return true	-- indicates successful touch
end
-- end tutorial functions
---------------------------------------------------------------

function initBalls()
	    for i=1,count do
	        countBalls[i] = AnimalBall:new(0,0, ballR*1.5, i)

	        countBalls[i]:insert( countBalls[i].ball )
	        countBalls[i]:insert( countBalls[i].text )


	        countBalls[i].x, countBalls[i].y = numberLine.num[i].x + numberLine.x, numberLine.num[i].y + numberLine.y - _H*0.030
                
                sceneGroup:insert(countBalls[i])
	    end
            
            moveBall = countBalls[1]

	    for i=1,count do
	        matchBalls[i] = Animal:new("images/puppy.png",  ballR*3, ballR*3, ballR*2)
	        matchBalls[i]:insert( matchBalls[i].ball )
            end
                -- hard coded ball positions
                matchBalls[1].x = _W * .5
                matchBalls[1].y = _H * .6
                
                -- will drag to this ball in demo
                matchBalls[2].x = _W * .3
                matchBalls[2].y = _H * .7
                animal = matchBalls[2]
                
                matchBalls[3].x = _W * .8
                matchBalls[3].y = _H * .8
                
	        sceneGroup:insert( matchBalls[1] )
                sceneGroup:insert( matchBalls[2] )
                sceneGroup:insert( matchBalls[3] )
	 --   end
end

function clearBalls()
	for i=1, count do
		sceneGroup:remove(matchBalls[i])
		matchBalls[i] = nil
	end
end

-- "scene:create()"
function scene:create( event )

    sceneGroup = self.view
		displayText = display.newText("", _W * .5, _H * .125, font, _W*.1)
		displayText:setFillColor(priColor.R, priColor.G, priColor.B)
    physics.setGravity(0,0)

    local background = display.newImageRect( "images/bg_blue_zig.png", 
            display.contentWidth, display.contentHeight )
    background.anchorX = 0
    background.anchorY = 0
    background.x, background.y = 0, 0
    sceneGroup:insert( background )

    --local coordinates =
    numberLine =  numLine:new(0, 10, _W*.9, 0 )
    numberLine.x , numberLine.y = _H*.1, _W*.2
    sceneGroup:insert(numberLine)

    decText  = display.newText( "", 0, 0, font, _W*.1 )
    decText.x, decText.y = _W*.833, _H*.6
    decText:setFillColor(priColor.R, priColor.G, priColor.B)
    sceneGroup:insert( decText )

    latText = display.newText( "", 0, 0, font, _W*.1 )
    latText.x, latText.y = _W*.833, _H*.75
    latText:setFillColor(priColor.R, priColor.G, priColor.B)
    sceneGroup:insert( latText )
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
 		initBalls()
                
    --------------------------------------
    -- timed function calls for tutorial objects and transitions
    
    -- delayed calls to display board and hand
    timer.performWithDelay( 500, showBoard)
    timer.performWithDelay( 500, showHand )  
    
    -- delayed calls to display board text 
    timer.performWithDelay( 1500, textDisplay )
    timer.performWithDelay( 5000, text2 )
    timer.performWithDelay( 9000, text3 )
    timer.performWithDelay( 11000, text4 )
       
    -- calls to number drag movements
    timer.performWithDelay( 2500, handMoveUp )
    timer.performWithDelay( 6000, handMoveDown )
    timer.performWithDelay( 7400, animalFade )
    
    -- call to remove tutorial objects and go to lesson 1
    timer.performWithDelay( 14000, endIntro )
       
end


-- "scene:show()"
function scene:show( event )

    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene
