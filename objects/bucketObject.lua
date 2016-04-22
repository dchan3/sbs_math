-- bucketObject.lua
-- still needs to dynamically adjuct to different screen sizes
-- currently looks best on ipad mini
------------------------------------------------------------
local physics = require "physics"
physics.start()
bucketObj = {}

function bucketObj:new( x,y )  -- constructor

    local bucket = display.newGroup()

    local bucketPic = display.newImage( bucket, "images/bucket.png", 0, 0 )
    -- may need adjustment due to different aspect ratios
--    bucketPic.width = _W*.25
    bucketPic.width = 250
--    bucketPic.height = _H*.35
    bucketPic.height = 250

    -- x, y, width, height
    local bottom = display.newRect(bucket, x, y, 180, 250)
    --bottom:setFillColor(0,0,0)
    bottom.isVisible = false
    physics.addBody(bottom, "static")
		bottom.isSensor = true

		bucket.x = x
		bucket.y = y

    return bucket
end

return bucketObj
