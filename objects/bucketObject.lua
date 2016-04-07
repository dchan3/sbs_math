-- bucketObject.lua
-- still needs to dynamically adjuct to different screen sizes
-- currently looks best on ipad mini
------------------------------------------------------------
local physics = require "physics"
physics.start()
bucketObj = {}

function bucketObj:new( x,y )  -- constructor

    local bucket = display.newGroup()

    local bucketPic = display.newImage( bucket, "images/bucket.png", x, y )
    -- may need adjustment due to different aspect ratios
--    bucketPic.width = _W*.25
    bucketPic.width = 250
--    bucketPic.height = _H*.35
    bucketPic.height = 250
    
    -- x, y, width, height
    bottom = display.newRect(bucket, x, y+120, 180, display.contentHeight*.01)
    --bottom:setFillColor(0,0,0)
    bottom.isVisible = false
    physics.addBody(bottom, "static")
    
    lside = display.newRect( bucket, x-100, y, display.contentWidth*.01, 250)
    --lside:setFillColor(1,0,1)
    lside.isVisible = false
    lside.rotation = 350
    physics.addBody(lside, "static")
    
    rside = display.newRect( bucket, x+100, y, display.contentWidth*.01, 250)
    --rside:setFillColor(1,0,1)
    rside.isVisible = false
    rside.rotation = 10
    physics.addBody(rside, "static")

    
    
    return bucket
end

return bucketObj


