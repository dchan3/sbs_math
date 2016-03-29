-- num input.lua
-- two digit number box for allowing user to select a number
-- max of leftmost digit, x, and y can be set during instanciation
-- example:
-- local numInput = require( "objects.numInput" )
-- local boxTest = numInput.new( 6, -190, 40 )
------------------------------------------------------------
numInput = {}
local widget = require( "widget" )

local leftNum = 0
local rightNum = 0
local strokeC = { 1, 0, 0.5 } --RGB, change or remove for final draft

function numInput:new( leftMax, x, y ) -- constructor

    local countBox = display.newGroup()
    countBox.num = 0
    
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
        countBox.num = finalNumber

        return finalNumber

    end

    -- rectanglular outer box, adjust looks as needed for final draft
    -- paremeters: parent, x, y, width, height
    local boxW = _W*0.25
    local boxH = _H*0.6

    local box = display.newRect(countBox, 0, 0, boxW, boxH )
        box:setFillColor( 1, 1, 1 )
        box.stroke = strokeC
        box.strokeWidth = 3
        box.alpha = 0.5

    -- buttons, adjust looks as needed for final draft
    local plusButtonL = widget.newButton{
                    id = "LeftPlus",
                    label="+",
                    labelColor = { default={0,255,50}, over={128} },
                    labelYOffset = 0, -- can remove this line
                    -- font = font,-- custom font not working correctly
                    fontSize = 20,
                    width = 100,
                    height = 100,
                    defaultFile="images/cat.png",
                    overFile="images/puppy.png",
                    onPress = onStepperPress,
            }
        plusButtonL.x = -boxW*.25
        plusButtonL.y = -boxH*.25

    local plusButtonR = widget.newButton{
                    id = "RightPlus",
                    label="+",
                    labelColor = { default={0,255,50}, over={128} },
                    labelYOffset = 0, -- can remove this line
                    -- font = font, -- custom font not working correctly
                    fontSize = 20,
                    width = 100,
                    height = 100,
                    defaultFile="images/cat.png",
                    overFile="images/puppy.png",
                    onPress = onStepperPress,
            }
        plusButtonR.x = boxW*.25
        plusButtonR.y = -boxH*.25

    local minusButtonL = widget.newButton{
                    id = "LeftMinus",
                    label="-",
                    labelColor = { default={255,0,50}, over={128} },
                    labelYOffset = 0, -- can remove this line
                    fontSize = 20,
                    width = 100,
                    height = 100,
                    defaultFile="images/mouse.png",
                    overFile="images/puppy.png",
                    onPress = onStepperPress,
            }
        minusButtonL.x = -boxW*.25
        minusButtonL.y = boxH*.25

    local minusButtonR = widget.newButton{
                    id = "RightMinus",
                    label="-",
                    labelColor = { default={255,0,50}, over={128} },
                    labelYOffset = 0, -- can remove this line
                    fontSize = 20,
                    width = 100,
                    height = 100,
                    defaultFile="images/mouse.png",
                    overFile="images/puppy.png",
                    onPress = onStepperPress,
            }
        minusButtonR.x = boxW*.25
        minusButtonR.y = boxH*.25

    local checkButton = widget.newButton{
                    label="!",
                    labelColor = { default={0,255,0}, over={128} },
                    labelYOffset = 0, -- can remove this line
                    fontSize = 20,
                    width = 100,
                    height = 100,
                    defaultFile="images/bunny.png",
                    overFile="images/puppy.png",
                    onPress = onCheck,
            }
        checkButton.x = 0
        checkButton.y = boxH*.40

    countBox:insert( plusButtonL )
    countBox:insert( plusButtonR )
    countBox:insert( minusButtonL )
    countBox:insert( minusButtonR )
    countBox:insert( checkButton )

    numTxtL = display.newText( leftNum, 0, 0, default, 55 )
            numTxtL:setFillColor( 0 )
            numTxtL.x = -boxW*.25
            numTxtL.y = 0

    numTxtR = display.newText( rightNum, 0, 0, default, 55 )
            numTxtR:setFillColor( 0 )
            numTxtR.x = boxW*.25
            numTxtR.y = 0

    countBox:insert ( numTxtL )
    countBox:insert ( numTxtR )

    countBox.x = x
    countBox.y = y

    return countBox
end

return numInput
