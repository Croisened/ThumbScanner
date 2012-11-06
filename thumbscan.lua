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

    local scanned = false
    local beam
    local trans1, trans2
    local scannerPOS = 740
    local beamPOS = 600
    local scannerButton
    local button1, button2, button3, button4, button5, button6, button6, button7, button8, button9, buttonReset
    local code = ""
    local denied
    local screenKey = "12345"
    local globalKey = ""
    local inputScreen, inputText, touchbg, cover
    local beepSound = audio.loadSound("sounds/beep2.wav")
    local scanSound = audio.loadSound("sounds/scan.wav")
    local alarmSound = audio.loadSound("sounds/alarm.wav")
	local w, h = display.contentWidth, display.contentHeight

	local screenGroup
	local beamGroup
	local background    

----------------------------------------------
-- Event listeners
----------------------------------------------

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

local moveAfterDelay = function()
	--Go back to the first screen
	storyboard.gotoScene( "scene1", "fromBottom", 800  )
    return true
end

    local listener1 = function( obj )
        --print( "Transition 1 completed on object: " .. tostring( obj ) )
       return true
    end

    local listener2 = function( obj )
        --print( "Transition 2 completed on object: " .. tostring( obj ) )
        scanned = true
        --print("target:" .. screenTarget)
        
        if code == screenKey then
          storyboard.gotoScene( "scene2", "fromBottom", 800  )
        else
          audio.play(alarmSound)
          denied.isVisible = true
          timer.performWithDelay(1000, moveAfterDelay, 1)      
        end 
        return true
        
    end	

	local runScan = function(event)
	 --run the scan in here
	 --print(event.phase)
	 audio.play(scanSound)
	 scannerButton.isVisible = false


	 local fingerprint = display.newImage("numpad/fingerprint.jpg", true)
	 fingerprint.x = display.contentWidth / 2
	 fingerprint.y = scannerPOS
	 beamGroup:insert(fingerprint)
	 
	 scanned = false
	 beam = display.newImage("numpad/beam.png", true)
	 beam.x = display.contentWidth / 2
	 beam.y = beamPOS
	 beamGroup:insert(beam)
	 
     trans1 = transition.to( beam, { time=600, alpha=1.0, y=(beamPOS + 260), onComplete=listener1 } )
     trans2 = transition.to( beam, { time=600, delay=602, y=beamPOS, alpha=0, onComplete=listener2 } )
 
	 
	end   
	
	local enterDigit = function(event)

      --add digit to code
      audio.play(beepSound)
      
      code = code .. tostring(event.target.id)

      inputScreen.isVisible = true
      inputText.text = tostring(code)
      
      --print(event.target.id)
      
	
	end 	 


	local SetupNumPad = function()

      button1 = widget.newButton{default = "numpad/button1.png",over = "numpad/button1over.png",onRelease = enterDigit,}
	  button1.x = 160; button1.y = 260; button1.id = 1; screenGroup:insert(button1);

      button2 = widget.newButton{default = "numpad/button2.png",over = "numpad/button2over.png",onRelease = enterDigit,}
	  button2.x = 320; button2.y = 260; button2.id = 2; screenGroup:insert(button2);

      button3 = widget.newButton{default = "numpad/button3.png",over = "numpad/button3over.png",onRelease = enterDigit,}
	  button3.x = 480; button3.y = 260; button3.id = 3; screenGroup:insert(button3);

      button4 = widget.newButton{default = "numpad/button4.png",over = "numpad/button4over.png",onRelease = enterDigit,}
	  button4.x = 160; button4.y = 385; button4.id = 4; screenGroup:insert(button4);

      button5 = widget.newButton{default = "numpad/button5.png",over = "numpad/button5over.png",onRelease = enterDigit,}
	  button5.x = 320; button5.y = 385; button5.id = 5; screenGroup:insert(button5);

      button6 = widget.newButton{default = "numpad/button6.png",over = "numpad/button6over.png",onRelease = enterDigit,}
	  button6.x = 480; button6.y = 385; button6.id = 6; screenGroup:insert(button6);

      button7 = widget.newButton{default = "numpad/button7.png",over = "numpad/button7over.png",onRelease = enterDigit,}
	  button7.x = 160; button7.y = 510; button7.id = 7; screenGroup:insert(button7);

      button8 = widget.newButton{default = "numpad/button8.png",over = "numpad/button8over.png",onRelease = enterDigit,}
	  button8.x = 320; button8.y = 510; button8.id = 8; screenGroup:insert(button8);

      button9 = widget.newButton{default = "numpad/button9.png",over = "numpad/button9over.png",onRelease = enterDigit,}
	  button9.x = 480; button9.y = 510; button9.id = 9; screenGroup:insert(button9);

	end


----------------------------------------------
--  BEGIN SCENE SETUP
----------------------------------------------
-- Called when the scene's view does not exist:
function scene:createScene( event )
	screenGroup = self.view
	beamGroup = display.newGroup()
	
	background = display.newImage("numpad/numpadback.jpg", true)
    screenGroup:insert(background)

	inputScreen = display.newRect(0,0,350, 60)
	inputScreen.x = display.contentWidth / 2
	inputScreen.y = 116
    inputScreen:setFillColor(0, 0, 0, 255)
	inputScreen.isVisible = false
    screenGroup:insert(inputScreen)

    inputText = display.newText("", 100, 50, getGlobal("FONTNAME"), 72)
    inputText:setTextColor(192, 223, 255, 255)
	inputText.x = display.contentWidth / 2
	inputText.y = 110
    screenGroup:insert(inputText)


	touchbg = display.newRect(0,0,300, 300)
    touchbg:setFillColor(0, 0, 0)
	touchbg.x = display.contentWidth / 2
	touchbg.y = scannerPOS    
    screenGroup:insert(touchbg)

	
    screenGroup:insert(beamGroup)


    scannerButton = widget.newButton{
    	default = "numpad/scanbutton.jpg",
	    over = "numpad/scanbuttonover.jpg",
	    onRelease = runScan,
    }
	scannerButton.x = display.contentWidth / 2
	scannerButton.y = scannerPOS    
    screenGroup:insert(scannerButton)

	SetupNumPad()

    denied = display.newImage( "numpad/acessdenied.jpg", true )
	denied.isVisible = false
	denied.x = w / 2
	denied.y = scannerPOS
	screenGroup:insert(denied)

    cover = display.newImage("numpad/cover.png", true)
	cover.x = display.contentWidth / 2
	cover.y = scannerPOS		
    screenGroup:insert(cover)

	
	print( "\nThumbscan: createScene event")
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	
	print( "thumbscan: enterScene event" )

	-- remove previous scene's view
	--storyboard.purgeScene(getGlobal("PREVSCENE"))
	storyboard.removeAll()
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	
	print( "thumbscan: exitScene event" )

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	  print( "((destroying thumbscan's view))" )
	  audio.dispose(beepSound)
	  beepSound = nil

	  audio.dispose(scanSound)
	  scanSound = nil

	  audio.dispose(alarmSound)
	  alarmSound = nil

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