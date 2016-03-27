-- bucketObject.lua
-- still needs to dynamically adjuct to different screen sizes
-- currently looks best on ipad mini
------------------------------------------------------------
local physics = require "physics"
physics.start()
bucketObj = {}

function bucketObj:new( x,y )  -- constructor

    local bucketPic = display.newImage( "images/bucket.png", x, y )
    -- may need adjustment due to different aspect ratios
--    bucketPic.width = _W*.25
    bucketPic.width = 250
--    bucketPic.height = _H*.35
    bucketPic.height = 250
    
    -- x, y, width, height
    bottom = display.newRect(x, y+120, 180, display.contentHeight*.01)
    --bottom:setFillColor(0,0,0)
    bottom.isVisible = false
    physics.addBody(bottom, "static")
    
    lside = display.newRect( x-100, y, display.contentWidth*.01, 250)
    --lside:setFillColor(1,0,1)
    lside.isVisible = false
    lside.rotation = 350
    physics.addBody(lside, "static")
    
    rside = display.newRect( x+100, y, display.contentWidth*.01, 250)
    --rside:setFillColor(1,0,1)
    rside.isVisible = false
    rside.rotation = 10
    physics.addBody(rside, "static")
    
    -- balls for testing only
    local ball = display.newCircle(display.contentCenterX, display.contentHeight*.2, display.contentHeight*.05)
    ball:setFillColor(1,0,1)
    physics.addBody(ball, "dynamic", {desity=1, friction=.3, bounce=.4})
    
    local ball2 = display.newCircle(display.contentCenterX*.9, display.contentHeight*.3, display.contentHeight*.06)
    ball2:setFillColor(1,0,0)
    physics.addBody(ball2, "dynamic", {desity=1, friction=.3, bounce=.4})
    
    
    --return bucketO
end

return bucketObj


