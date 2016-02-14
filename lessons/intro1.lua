local composer = require( "composer" )
local numLine = require( "objects.numLine" )
local animal = require("objects.animal")
local animalball = require("objects.animalball")
local physics = require "physics"
physics.start()
--physics.setDrawMode( "hybrid" )


local scene = composer.newScene()

local hasCollidedCircle

local max = 3
local count = max -- math.random( 1, max)
--local matchCount = count
local map = { false, false, false, false, false, false, false, false, false, false,  false, false, false, false, false }

local countBalls = {}
local matchBalls = {}
local numberLine
local displayText = {}

local sceneGroup

local decText
local latText

local selText = display

-- variables and functions for tutorial -------------------------------------

local boardText
local hand
local board
local tryText
local moveBall
local animal

-- displays chalk board
local function showBoard ( event )
    board = display.newImage( "images/small_chalkboard.png" )
    board.x = _W * .7
    board.y = _H * .25
    board:scale(.8, .8)
    board.alpha = 0
    transition.fadeIn( board, {time=500} )   
end

local function showHand ( event )
    hand = display.newImage( "images/hand.png" )
    hand.x = _W * .6
    hand.y = _H -50
    hand.alpha = 0
    transition.fadeIn( hand, {time=500} )
end

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
    boardText.text = "now YOU try!"
    boardText:setFillColor(1,0,0)
end

local function handMoveUp( event )
    transition.to(hand, {x= _W * .25, y=_H -380, time=2000 })
end

local function handMoveDown ( event )
    transition.to(hand, {x= _W *.4, y= _H*.8, time=1500 })
    transition.to(moveBall, {x= _W *.3, y= _H*.7, time=1500 })
end

local function animalFade ( event )
    animal.alpha = .3
end

local function youTry ( event )
    tryText = display.newText( "Now you try!", _W*.5, _H*.6, font, 80)
    tryText:setFillColor(1,0,0)
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
--[[
local function drag( event )
    local t = event.target

    -- Print info about the event. For actual production code, you should
    -- not call this function because it wastes CPU resources.
    --printTouch(event)

    local phase = event.phase
    if "began" == phase then
        -- Make target the top-most object
        local parent = t.parent
        parent:insert( t )
        display.getCurrentStage():setFocus( t )

        decText.text = t.num
        local text = convertDecToLat( t.num )
        latText.text = text
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

        elseif "ended" == phase or "cancelled" == phase then

                print(t.cooldedWith)

                if(t.collidedWith ~= nil) then

                    hasCollidedCircle(t, t.collidedWith )

                end

            display.getCurrentStage():setFocus( nil )
            t.isFocus = false
        end
    end

    -- Important to return true. This tells the system that the event
    -- should not be propagated to listeners of any objects underneath.
    return true
end 

local function onLocalCollision( self, event )
   local t = event.target
   local o = event.other

    if ( event.phase == "began" ) then

        if (event.other.matched == false) then
            event.other.num = self.num
            self.collidedWith = event.other

        end

    elseif ( event.phase == "ended" ) or ( event.phase == "cancelled" ) then

        if (event.other.matched == false) then
            event.other.num = self.num
            self.collidedWith = event.other
        end

    end
end


function hasCollidedCircle(obj1, obj2)

    if obj1 == nil then
        return false
    end

    if obj2 == nil then
        return false
    end

    local sqrt = math.sqrt
    local dx =  obj1.x - obj2.x;
    local dy =  obj1.y - obj2.y;
    local distance = sqrt(dx*dx + dy*dy);
    local objectSize = (obj2.contentWidth/2) + (obj1.contentWidth/2)

    if distance < objectSize then

                    local function listener( event )
                        display.remove(obj1)
                    end


                    local transitionTime = 100


                    transition.to(obj1,
                    {
                        time=transitionTime,
                        x = obj2.x,
                        y= obj2.y,
                        onComplete = listener
                    })

                   obj2.text = display.newText( obj1.num, 0, 0, font, ballR*2 )
                    obj2.text:setFillColor(0,0,0)
                    obj2.text.alpha = 0
                    obj2.num = obj1.num
                    obj2:insert( obj2.text )
                    obj2.matched = true


                    local function listener( event )
                        transition.to(obj2.text,
                        {
                        time=500,
                        alpha =.75
                        })
                    end
                    timer.performWithDelay( transitionTime, listener )

                    matchCount = matchCount - 1

                    if matchCount <= 0 then
											decText.text = ""
											latText.text = ""
                      check()
											matchCount = count
                    end
        print("true")
        return true
    end
    return false
end
]]--
--[[
function reset()
	displayText.text = ""
	clearBalls()
	count = math.random(1,max)
    	matchCount = count
  	initBalls()
end ]]--
--[[
function check()

	for i=1, count do
			local distance = math.pow( (math.pow( matchBalls[i].x - numberLine.x, 2 ) + math.pow( matchBalls[i].y, 2 )), .5  )
			local time = distance/maxSpeed*1000
			--print( numberLine.num[i].text .. " : ".. distance .. " : ".. time)
			transition.moveTo( matchBalls[i], {x = numberLine.hash[matchBalls[i].num].x + numberLine.x, y = numberLine.hash[matchBalls[i].num].y + numberLine.y, time=1000})
			--transition.matTrans( matchBalls[i], numberLine.hash[matchBalls[i].num].x + numberLine.x, numberLine.hash[matchBalls[i].num].y + numberLine.y, time )
	end

	for j=1,count do
		timer.performWithDelay(j * 1000, function (event) displayText.text = convertDecToLat(j) end)

        for i = 1, count do
            if matchBalls[i].num == j then
                timer.performWithDelay(j * 1000, 
                    function (event)  
                    matchBalls[i].outline:setFillColor(hlColor.R, hlColor.G, hlColor.B)
                end)
            end
        end
	end

	local currScene = composer.getSceneName( "current" )
	print(currScene)
	timer.performWithDelay((count + 1) * 1000, function (event) reset() end)

end ]]--

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
    -- tutorial display objects, controled timing
    
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
