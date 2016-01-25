local composer = require( "composer" )
--local numLine = require( "numLine" )
local numLine = require( "objects.tenNumLine" )
local animal = require("objects.animal")
--local animalball = require("animalball")
local tenball = require("objects.tenball")
local physics = require "physics"
physics.start()
physics.setDrawMode( "hybrid" )


local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local hasCollidedCircle

local max = 10
local count = max -- math.random( 1, max)
local matchCount = count
local map = { false, false, false, false, false, false, false, false, false, false,  false, false, false, false, false }

local countBalls = {}
local matchBalls = {}
local numberLine

local decText
local latText

local selText = display

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

        decText.text = t.num*10
        local text = convertDecToTens( t.num*10 )
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

                   obj2.text = display.newText( obj1.num*10, 0, 0, font, ballR*2 )
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
                        local options = { effect = "crossFade", time = 500, params = { count = count , map = map, matchBalls = matchBalls } }
                        composer.gotoScene( "tenCountCheck", options )
                    end
        print("true")
        return true
    end
    return false
end





-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    physics.setGravity(0,0)

    --local coordinates =
    numberLine =  numLine:new(1, 10, _W*.9, 0 )
    numberLine.x , numberLine.y = _H*.1, _W*.2
    sceneGroup:insert(numberLine)

    decText  = display.newText( 0, 0, 0, font, _W*.1 )
    decText.x, decText.y = _W*.833, _H*.6
    decText:setFillColor(Blue.R, Blue.G, Blue.B)
    sceneGroup:insert( decText )

    latText = display.newText( "Zero", 0, 0, font, _W*.1 )
    latText.x, latText.y = _W*.833, _H*.75
    latText:setFillColor(Blue.R, Blue.G, Blue.B)
    sceneGroup:insert( latText )


    for i=1,count do
        countBalls[i] = TenBall:new(0,0, ballR, i)
        countBalls[i]:addEventListener( "touch", drag )

        countBalls[i]:insert( countBalls[i].ball )
        countBalls[i]:insert( countBalls[i].text )


        countBalls[i].x, countBalls[i].y = numberLine.num[i].x + numberLine.x, numberLine.num[i].y + numberLine.y + _H*0.09375

        physics.addBody( countBalls[i], { radius=ballR } )
        countBalls[i].isSensor = true
        countBalls[i].collision = onLocalCollision
        countBalls[i]:addEventListener( "collision", countBalls[i] )

        sceneGroup:insert(countBalls[i])
    end



    for i=1,count do
        --matchBalls[i] = Animal:new("dog.png",  ballR*3, ballR*3, ballR*2)
        matchBalls[i] = Animal:new("tenDogs.png",  ballR*5, ballR*5, ballR*4)
        matchBalls[i]:addEventListener( "touch", drag )
        matchBalls[i]:insert( matchBalls[i].ball )

        --places balls in grid
        while  matchBalls[i].x == 0 and  matchBalls[i].y == 0 do

            local randomLocation = math.random(1, 15)

            if map[randomLocation] == false then
                --matchBalls[i].x, matchBalls[i].y = _W *.5 /6 +  _W *.5 /3 * (randomLocation % 3), _H*.1 + _H*.2*math.floor((randomLocation-1) / 3)
									matchBalls[i].x, matchBalls[i].y = _W*.05 + _W*.1*math.floor((randomLocation-1) / 3), _H *.5 / 6 + _H * .5 / 3 * (randomLocation % 3) + _H *.5
									map[randomLocation] = true

            end

        end

        physics.addBody( matchBalls[i], { radius=ballR*1.25 } )

        sceneGroup:insert( matchBalls[i] )
    end



    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
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

    local sceneGroup = self.view
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

    local sceneGroup = self.view

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
