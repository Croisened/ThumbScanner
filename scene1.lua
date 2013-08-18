---------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------
local storyboard = require "storyboard" 
local widget = require "widget"

local scene = storyboard.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local image, text1, text2, memTimer
local standardLabelColors = getGlobal("STANDARDLABELCOLORS")

----------------------------------------------
-- Event listeners
----------------------------------------------
local moveToScene = function(event)

        print(event.phase)
		storyboard.gotoScene( "thumbscan", "fromTop", 800  )
        return true
end

--[[
local function fieldHandler( event )

	if ( "began" == event.phase ) then
		-- This is the "keyboard has appeared" event
		-- In some cases you may want to adjust the interface when the keyboard appears.
	
	elseif ( "ended" == event.phase ) then
		-- This event is called when the user stops editing a field: for example, when they touch a different field
	
	elseif ( "submitted" == event.phase ) then
		-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
		
		-- Hide keyboard
		native.setKeyboardFocus( nil )
	end
end	
--]]


----------------------------------------------
--  BEGIN SCENE SETUP
----------------------------------------------
-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	
	image = display.newImage( "images/bg.jpg", true )
	screenGroup:insert( image )
	
	text1 = display.newText( "Welcome", 0, 0, native.systemFontBold, 32 )
	text1:setTextColor(standardLabelColors["r"], standardLabelColors["g"], standardLabelColors["b"])
	text1:setReferencePoint( display.CenterReferencePoint )
	text1.x, text1.y = display.contentWidth * 0.5, 50
	screenGroup:insert( text1 )
	
	text2 = display.newText( "", 0, 0, getGlobal("FONTNAME"), 32 )
	text2:setTextColor(standardLabelColors["r"], standardLabelColors["g"], standardLabelColors["b"])
	text2:setReferencePoint( display.CenterReferencePoint )
	text2.x, text2.y = display.contentWidth * 0.5, display.contentHeight * 0.5
	screenGroup:insert( text2 )
	
	--[[
    nameField = native.newTextField(10, 190, 400, getGlobal("TEXTFIELDSIZE"))
    nameField:addEventListener("userInput", fieldHandler)
    nameField.font = native.newFont( native.systemFontBold, getGlobal("TEXTFIELDFONTSIZE"))
    nameField.inputType = "default"
    nameField:setReferencePoint(display.TopLeftReferencePoint)
    nameField.x = 120
    nameField.y = 240
    nameField.text = ""
    screenGroup:insert(nameField)	
    --]]

    local homeButton = widget.newButton{
    	defaultFile = "images/scene1button.png",
	    overFile = "images/scene1buttonover.png",
	    onRelease = moveToScene,
    }
    homeButton.x = display.contentWidth / 2
    homeButton.y = 200

    screenGroup:insert(homeButton)	
	
	print( "\n1: createScene event")
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	
	print( "1: enterScene event" )
	
	-- remove previous scene's view
	--storyboard.purgeScene(getGlobal("PREVSCENE"))
	storyboard.removeAll()
	
	-- Update Lua memory text display
	if getGlobal("DEBUG") then
	  local showMem = function()
		  text2.text = "MemUsage: " .. collectgarbage("count")/1000 .. "MB"
    	  text2.x = display.contentWidth * 0.5
	  end
	  memTimer = timer.performWithDelay( 1000, showMem, 1 )
    end

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	
	print( "1: exitScene event" )
	-- reset label text
	text2.text = ""

	-- cancel timer
	if getGlobal("DEBUG") then
	  timer.cancel( memTimer ); memTimer = nil;
	end  
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	print( "((destroying scene 1's view))" )
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene