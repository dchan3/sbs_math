-- num input.lua
-- two digit number box for allowing user to select a number
-- max of leftmost digit, x, and y can be set during instanciation
-- example:
-- local numInput = require( "objects.numInput" )
-- local boxTest = numInput.new( 6, -190, 40 )
------------------------------------------------------------
local widget = require( "widget" )

local numInput = {}

local countBox = display.newGroup()
local leftNum = 0
local rightNum = 0
local strokeC = { 1, 0, 0.5 } --RGB, change or remove for final draft

function numInput.new( leftMax, x, y ) -- constructor
      
    leftMax = leftMax or 9
    x = x or 0
    y = y or 0

    -- Handle number stepper events
    local function onStepperPress( event )
        local id = event.target.id

        --increments on left plus press
        if id == "LeftPlus" and leftNum < leftMax then
            leftNum = leftNum + 1   
            numTxtL.text = leftNum	
            print( leftNum ) -- can remove this line
        end

        --increments on right plus press
        if id == "RightPlus" and rightNum < 9 then
            rightNum = rightNum + 1   
            numTxtR.text = rightNum	
            print( rightNum ) -- can remove this line
        end

        --increments on left plus press
        if id == "LeftMinus" and leftNum > 0 then
            leftNum = leftNum - 1   
            numTxtL.text = leftNum	
            print( leftNum ) -- can remove this line
        end

        --increments on right plus press
        if id == "RightMinus" and rightNum > 0 then
            rightNum = rightNum - 1   
            numTxtR.text = rightNum	
            print( rightNum ) -- can remove this line
        end

        return true       
    end

    
    -- NEED TO MAKE finalNumber ACCESSIBLE BY OTHER OBJECTS
    function onCheck ( event )

        finalNumber = leftNum * 10 + rightNum
        print ( finalNumber ) -- can remove this line

        return finalNumber

    end

    -- rectanglular outer box, adjust looks as needed for final draft
    -- paremeters: parent, x, y, width, height
    local box = display.newRect(countBox, display.contentWidth*0.5,
                                        display.contentHeight -175, 100, 180 )

        box:setFillColor( 1, 1, 1 )
        box.stroke = strokeC
        box.strokeWidth = 3

    -- buttons, adjust looks as needed for final draft
    local plusButtonL = widget.newButton{
                    id = "LeftPlus",
                    label="+",
                    labelColor = { default={0,255,50}, over={128} },
                    labelYOffset = 0, -- can remove this line
                    -- font = font,-- custom font not working correctly
                    fontSize = 20,
                    defaultFile="images/Icon-Small.png",
                    overFile="images/Icon-Small-40.png",
                    onPress = onStepperPress,
            }
        plusButtonL.x = display.contentWidth*0.45
        plusButtonL.y = display.contentHeight*0.25

    local plusButtonR = widget.newButton{
                    id = "RightPlus",
                    label="+",
                    labelColor = { default={0,255,50}, over={128} },
                    labelYOffset = 0, -- can remove this line
                    -- font = font, -- custom font not working correctly
                    fontSize = 20,
                    defaultFile="images/Icon-Small.png",
                    overFile="images/Icon-Small-40.png",
                    onPress = onStepperPress,
            }
        plusButtonR.x = display.contentWidth*0.55
        plusButtonR.y = display.contentHeight*0.25

    local minusButtonL = widget.newButton{
                    id = "LeftMinus",
                    label="-",
                    labelColor = { default={255,0,50}, over={128} },
                    labelYOffset = 0, -- can remove this line
                    fontSize = 20,
                    defaultFile="images/Icon-Small.png",
                    overFile="images/Icon-Small-40.png",
                    onPress = onStepperPress,
            }
        minusButtonL.x = display.contentWidth*0.45
        minusButtonL.y = display.contentHeight*0.54

    local minusButtonR = widget.newButton{
                    id = "RightMinus",
                    label="-",
                    labelColor = { default={255,0,50}, over={128} },
                    labelYOffset = 0, -- can remove this line
                    fontSize = 20,
                    defaultFile="images/Icon-Small.png",
                    overFile="images/Icon-Small-40.png",
                    onPress = onStepperPress,
            }
        minusButtonR.x = display.contentWidth*0.55
        minusButtonR.y = display.contentHeight*0.54

    local checkButton = widget.newButton{
                    label="!",
                    labelColor = { default={0,255,0}, over={128} },
                    labelYOffset = 0, -- can remove this line
                    fontSize = 20,
                    defaultFile="images/Icon-Small.png",
                    overFile="images/Icon-Small-40.png",
                    onPress = onCheck,
            }
        checkButton.x = display.contentWidth*0.5
        checkButton.y = display.contentHeight*0.65

    countBox:insert( plusButtonL )
    countBox:insert( plusButtonR ) 
    countBox:insert( minusButtonL )
    countBox:insert( minusButtonR )
    countBox:insert( checkButton )

    numTxtL = display.newText( leftNum, 0, 0, default, 55 )
            numTxtL:setFillColor( 0 )
            numTxtL.x = display.contentWidth*0.45
            numTxtL.y = display.contentHeight*0.38 

    numTxtR = display.newText( rightNum, 0, 0, default, 55 )
            numTxtR:setFillColor( 0 )
            numTxtR.x = display.contentWidth*0.55
            numTxtR.y = display.contentHeight*0.38 

    countBox:insert ( numTxtL )
    countBox:insert ( numTxtR )

    countBox.x = x
    countBox.y = y

end

return numInput
