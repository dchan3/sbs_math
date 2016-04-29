local composer = require( "composer" )
local clockA = require("objects.aclock")
local clockD = require("objects.dclock")
local physics = require "physics"
physics.start()
physics.setDrawMode("hybrid")

local scene = composer.newScene()

local analog = {}
local digital = {}

function scene:create( event )
	sceneGroup = self.view
	analog = aClock:new(250, 250)
	digital = dClock:new(1200, 1000, true, 1, 30)
	sceneGroup:insert(analog)
end

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

function scene:destroy( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
