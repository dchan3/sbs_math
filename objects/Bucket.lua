Bucket = {}

function Bucket:new( bucketH, bucketW )


	local bucket = display.newImage( "images/bucket.png" )
	bucket.width = bucketH
    bucket.height = bucketW

	local leftSide =	{ -bucketW*.5,bucketH*.5,	 -bucketW*.5, -bucketH*.5, 		 -bucketW*.65*.5, bucketH*.5	}
	local rightSide = 	{  bucketW*.5,bucketH*.5,	  bucketW*.5, -bucketH*.5, 		  bucketW*.65*.5, bucketH*.5	}
	local botL = 		{ -bucketW*.5,bucketH*.4,		0,bucketH*.45,		0,bucketH*.5,		-bucketW*.5,bucketH*.5 }
	local botR = 		{  bucketW*.5,bucketH*.4,		0,bucketH*.45,		0,bucketH*.5,		 bucketW*.5,bucketH*.5}

	physics.addBody( bucket, "static", {friction = 1, shape=leftSide}, {friction = 1, shape=rightSide}, 
	{ friction = 1, shape=botL}, {friction = 1, shape=botR} ) --, {shape=beamRBR}, {shape=beamRBL} )

	return bucket
end

return Bucket