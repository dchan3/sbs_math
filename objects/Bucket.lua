Bucket = {}

function Bucket:new( bucketH, bucketW )


	local bucket = display.newImage( "images/bucket.png" )
	bucket.width = 250
    bucket.height = 250

	local leftSide =	{ -bucketW*.5,bucketH*.5,	 -bucketW*.5, -bucketH*.5, 		 -bucketW*.65*.5, bucketH*.5	}
	local rightSide = 	{  bucketW*.5,bucketH*.5,	  bucketW*.5, -bucketH*.5, 		  bucketW*.65*.5, bucketH*.5	}
	local botL = 		{ -bucketW*.5,bucketH*.4,		0,bucketH*.45,		0,bucketH*.5,		-bucketW*.5,bucketH*.5 }
	local botR = 		{  bucketW*.5,bucketH*.4,		0,bucketH*.45,		0,bucketH*.5,		 bucketW*.5,bucketH*.5}

	physics.addBody( bucket, "static", {shape=leftSide}, {shape=rightSide}, {shape=botL}, {shape=botR} ) --, {shape=beamRBR}, {shape=beamRBL} )

	return bucket
end

return Bucket