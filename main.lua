--Hide the Device Status bar
display.setStatusBar( display.HiddenStatusBar )

--Prevent the device form going to sleep wheil in this app
system.setIdleTimer(false)

--====================================================================--
-- Fully Croisened Project Template
--====================================================================--
--[[
   - Version: 2.0
   - This version is re-vamped to drive entirely off the Storyboard
--]]

--====================================================================--
-- IMPORT DIRECTOR CLASS
--====================================================================--

local storyboard = require "storyboard"
local widget = require "widget"
local globals = require "globals"
local downPress = false

--====================================================================--
-- MAIN FUNCTION
--====================================================================--

local main = function ()

    ------------------
    -- Setup Globals
    ------------------
    setupGlobals()

	------------------
	-- Load the first scene scene without effects
    --print(getGlobal("NEXTSCENE"))
	------------------
    storyboard.gotoScene("scene1", "fade", 400 )

    --
    -- Display objects added below will not respond to storyboard transitions
    --
    -- table to setup tabBar buttons
    --[[  
    local tabButtons = {
      { label="First", up="images/icon1.png", down="images/icon1-down.png", width = 32, height = 32, selected=true },
      { label="Second", up="images/icon2.png", down="images/icon2-down.png", width = 32, height = 32 },
    }

    -- create the actual tabBar widget
    local tabBar = widget.newTabBar{
      top = display.contentHeight - 50,   -- 50 is default height for tabBar widget
      buttons = tabButtons
    }
    --]]

	return true
end

--------------------------------------------------------------------------------
-- Android "restart" Wakeup Code (forces a display update after 250 msec)
--
-- If applicationStart then fire a 250 ms timer.
-- After 250 ms, changes the Alpa value of the Current Stage (group)
-- This forces a display update to wake up the screen
-------------------------------------------------------------------------
local function onBackButtonPressed(e)
    if (e.phase == "down" and e.keyName == "back") then
        downPress = true
        else if (e.phase == "up" and e.keyName == "back" and downPress) then
            -- do whatever (generally changing scene)
            -- also don't forget to do this if changing scene: Runtime:removeEventListener( key,onBackButtonPressed)
        end
    end
    return true
end

local function onAndroidSystemEvent( event ) 
        
        local timerEnd = function()
                local t = display.getCurrentStage()
                t.alpha = 0.9           -- force a display update
                timer.performWithDelay( 1, function() t.alpha = 1.0 end ) -- wait one frame
        end
        
        local appEnd = function()
                --print("app exit hit")
                local t = display.getCurrentStage()
                t.alpha = 1           -- begin fade out...
                timer.performWithDelay( 1, function() t.alpha = 0.5 end ) -- wait one frame
        end        
        
        -- Start timer if this is an application start event
        if "applicationStart" == event.type then
                timer.performWithDelay( 250, timerEnd )
        elseif "applicationExit" == event.type then
           timer.performWithDelay(250, appEnd)
        end
end
 
-- Add the System callback event if Android
if "Android" == system.getInfo( "platformName" ) then
   Runtime:addEventListener( "system", onAndroidSystemEvent )
   Runtime:addEventListener( "key", onBackButtonPressed )
end
------------------------------------------------------------------------

--====================================================================--
-- BEGIN
--====================================================================--

main()

-- It's that easy! :-)
