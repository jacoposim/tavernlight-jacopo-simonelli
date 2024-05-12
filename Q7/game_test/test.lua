testWindow = nil
button = nil

local offset = 50 --value to add/subtract to the window width/height to make the button fit perfectly
local speed = 10 --the movement loop will be called every 'speed' milliseconds

function init()
	--open the window immediately after the module is loaded
	openWindow()
end

function terminate()
		if testWindow then
		testWindow:destroy()
		testWindow = nil
		button = nil
	end
end

function openWindow()
  --display the window
  testWindow = g_ui.displayUI('test.otui')
  
  --get the moving button reference
  button = testWindow:getChildById('movingButton')
  
  --call button movement function
  movementLoop()
  
  --button click manager
  button.onClick =
    function()
		--after clicking it, the button will respawn in the window at the right margin and at a random height
		local newXPos = testWindow:getX() + testWindow:getWidth() - offset
	    local newYPos = math.random(testWindow:getY() + offset, testWindow:getY() + testWindow:getHeight() - offset)
	    button:setX(newXPos)
	    button:setY(newYPos)
    end
end

function movementLoop()	
	--stop loop if window is closed 
	if not button then
		return
	end
	
	--button X position relative to the window
	local relativeXPos = button:getX() - testWindow:getX()
	
	local newXPos = testWindow:getX() + testWindow:getWidth() - offset
	local newYPos = math.random(testWindow:getY() + offset, testWindow:getY() + testWindow:getHeight() - offset)
	
	--after reaching the window left margin, the button will respawn in the window at the right margin and at a random height
	if (relativeXPos == 10) then
		button:setX(newXPos)
		button:setY(newYPos)
	end
	
	--make the button move
	button:setX(button:getX() - 1)
	
	--loop this function
	scheduleEvent(movementLoop, speed)
end
