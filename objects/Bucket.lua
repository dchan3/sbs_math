Bucket = {}

function Bucket:new( bucketH, bucketW )
	

	local bucket = display.newCircle( 0,0, 2)

	local leftSide =	{ -bucketW*.5,0,	 -bucketW*.5, -bucketH, 		 -bucketW*.65*.5, 0	}
	local rightSide = 	{  bucketW*.5,0,	  bucketW*.5, -bucketH, 		  bucketW*.65*.5, 0	}
	local botL = 		{ -bucketW*.5,-bucketH*.1,		0,-bucketH*.05,		0,0,		-bucketW*.5,0 }
	local botR = 		{  bucketW*.5,-bucketH*.1,		0,-bucketH*.05,		0,0,		 bucketW*.5,0}

	physics.addBody( bucket, "static", {shape=leftSide}, {shape=rightSide}, {shape=botL}, {shape=botR} ) --, {shape=beamRBR}, {shape=beamRBL} )

	return bucket
end

return Bucket