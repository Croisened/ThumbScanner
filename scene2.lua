---------------------------------------------------------------------------------
--
-- scene2.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local image, text1, text2, text3, memTimer
local standardLabelColors = getGlobal("STANDARDLABELCOLORS")


local function onSceneTouch( self, event )
	if event.phase == "began" then
		
		storyboard.gotoScene("scene1" , "slideRight", 800  )
		
		return true
	end
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	
	image = display.newImage( "images/bg.jpg" )
	screenGroup:insert( image )
	
	image.touch = onSceneTouch
	
	text1 = display.newText( "Scene 2", 0, 0, native.systemFontBold, 32 )
	text1:setTextColor(standardLabelColors["r"], standardLabelColors["g"], standardLabelColors["b"])
	text1:setReferencePoint( display.CenterReferencePoint )
	text1.x, text1.y = display.contentWidth * 0.5, 50
	screenGroup:insert( text1 )
	
	text2 = display.newText( "MemUsage: ", 0, 0, native.systemFont, 32 )
	text2:setTextColor(standardLabelColors["r"], standardLabelColors["g"], standardLabelColors["b"])
	text2:setReferencePoint( display.CenterReferencePoint )
	text2.x, text2.y = display.contentWidth * 0.5, display.contentHeight * 0.5
	screenGroup:insert( text2 )
	
	text3 = display.newText( "Touch to return...", 0, 0, native.systemFontBold, 32 )
	text3:setTextColor(standardLabelColors["r"], standardLabelColors["g"], standardLabelColors["b"]); text3.isVisible = false
	text3:setReferencePoint( display.CenterReferencePoint )
	text3.x, text3.y = display.contentWidth * 0.5, display.contentHeight - 100
	screenGroup:insert( text3 )
	
	print( "\n2: createScene event" )
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	
	print( "2: enterScene event" )

	-- remove previous scene's view
	--storyboard.purgeScene(getGlobal("PREVSCENE"))
	storyboard.removeAll()

	-- Update Lua memory text display
    image:addEventListener( "touch", image )

	if getGlobal("DEBUG") then
	  local showMem = function()
		  text3.isVisible = true
		  text2.text = text2.text .. collectgarbage("count")/1000 .. "MB"
    	  text2.x = display.contentWidth * 0.5
	  end
	  memTimer = timer.performWithDelay( 1000, showMem, 1 )
    end
    
end


-- Called when scene is about to move offscreen:
function scene:exitScene()
	
	print( "2: exitScene event\n" )

    -- remove touch listener for image
	image:removeEventListener( "touch", image )
	
	if getGlobal("DEBUG") then
	  -- cancel timer
	  timer.cancel( memTimer ); memTimer = nil;
	end  

	
	-- reset label text
	text2.text = "MemUsage: "
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	print( "((destroying scene 2's view))" )
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