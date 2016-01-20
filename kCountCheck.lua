local composer = require( "composer" )
local numLine = require( "numLine" )
local animal = require("animal")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local matchBalls = {}
local count = 0
local text = "";
local displayText = {};

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    numberLine =  numLine:new(0, 10, _W*.9, 0 )
    numberLine.x , numberLine.y = _H*.1, _W*.2
    sceneGroup:insert(numberLine)
		displayText = display.newText(text, _W * .5, _H * .125, native.systemFont, _W*.1)
    displayText:setFillColor(Blue.R, Blue.G, Blue.B)

		matchBalls = event.params.matchBalls
    table.sort(matchBalls, function(a,b) return a.num < b.num end)

		--matchBalls = event.params.matchBalls
    count = event.params.count
    for i=1,count do
        --[[
        --matchBalls[i]:insert( matchBalls[i].ball )
        --matchBalls[i]:insert( matchBalls[i].text )
        --local oldX = matchBalls[i].x
        --local oldY = matchBalls[i].y
        --matchBalls[i].x, matchBalls[i].y = oldX, oldY
        --physics.addBody( matchBalls[i], { radius=ballR*2 } )]]
        numberLine.num[i] = i
        sceneGroup:insert(matchBalls[i])
    end
--[[
    for i=1, 15 do
        print(event.params.map[i])
    end
]]
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

        for i=1, event.params.count do


            local distance = math.pow( (math.pow( matchBalls[i].x - numberLine.x, 2 ) + math.pow( matchBalls[i].y, 2 )), .5  )
            local time = distance/maxSpeed*1000
            --print( numberLine.num[i].text .. " : ".. distance .. " : ".. time)
            transition.moveTo( matchBalls[i], {x = numberLine.hash[matchBalls[i].num].x + numberLine.x, y = numberLine.hash[matchBalls[i].num].y + numberLine.y, time=1000})
						--transition.matTrans( matchBalls[i], numberLine.hash[matchBalls[i].num].x + numberLine.x, numberLine.hash[matchBalls[i].num].y + numberLine.y, time )

        end

		for j=1,count do
			timer.performWithDelay(j * 1000, 
                function (event)  
                    displayText.text = convertDecToLat(j) 
                    matchBalls[j].outline:setFillColor(Blue.R, Blue.G, Blue.B)
                    if j > 1 then
                    matchBalls[j-1].outline:setFillColor(225/225,193/225,102/225)
                    end
                end)

        end
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
