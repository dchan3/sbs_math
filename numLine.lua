NumLine = {}

--:new( minumum number, max number, total length of line, angle of line )

function NumLine:new( min, max, length, angle )

  local line = display.newGroup()
  local range = max - min
  local anglePerp = math.rad(angle) + 1.57079633 
  local hashW = fontSize*.25
  local step =  length/range 

  
  line.line = display.newLine( line, 0, 0, length, 0 )
  line.line.rotation = angle
  line.line.strokeWidth = _H*.005
  line.line:setStrokeColor(0,0,0)

  line:insert(line.line) 

  line.num = {}
  line.hash = {}

  for i=0,range do 
    line.num[i] = display.newText( i, step*i*math.cos(math.rad(angle)) - 3*hashW*math.cos(anglePerp), 
                step*i*math.sin(math.rad(angle) ) - 3*hashW*math.sin(anglePerp), native.systemFont, fontSize  )
    line.num[i]:setFillColor( Blue.R,Blue.G,Blue.B )

    line.hash[i] = display.newLine(   step*i*math.cos(math.rad(angle)) - hashW*math.cos(anglePerp), step*i*math.sin(math.rad(angle)) - hashW*math.sin(anglePerp),
               step*i*math.cos(math.rad(angle)) + hashW*math.cos(anglePerp), step*i*math.sin(math.rad(angle)) + hashW*math.sin(anglePerp)    )
    line.hash[i].strokeWidth = _H*.01
    line.hash[i]:setStrokeColor(0,0,0)

    
    line:insert( line.hash[i] )
    line:insert( line.num[i] ) 

  end

  --


  return line
end


return NumLine
