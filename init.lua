local function launchOrFocusOrRotate(app)
    local focusedWindow = hs.window.focusedWindow()
    local focusedWindowApp = focusedWindow:application()
    local focusedWindowAppName = focusedWindowApp:name()
  
    local focusedWindowPath = focusedWindowApp:path()
  
    -- extract application from path
    local appNameOnDisk = string.gsub(focusedWindowPath,"/Applications/", "")
    local appNameOnDisk = string.gsub(appNameOnDisk,".app", "")
    local appNameOnDisk = string.gsub(appNameOnDisk,"/System/Library/CoreServices/","")
  
    -- If already focused, rotate windows
    if focusedWindow and appNameOnDisk == app then
      local appWindows = hs.application.get(focusedWindowAppName):allWindows()
  
      if #appWindows > 0 then
          if app == "Finder" then
            appWindows[#appWindows-1]:focus()
          else
            appWindows[#appWindows]:focus()
          end
      else 
          hs.application.launchOrFocus(app)
      end
    else -- if not focused
      hs.application.launchOrFocus(app)
    end
  end
  
-- Application switching for work tools
hs.loadSpoon("AppWindowSwitcher")
--:setLogLevel("debug") -- console debug 
:bindHotkeys({
    ["com.googlecode.iterm2"]        = {{"ctrl", "alt", "cmd"}, "t"},
    ["fm.anytype.anytype"]           = {{"ctrl", "alt", "cmd"}, "a"},
    ["com.microsoft.VSCode"]         = {{"ctrl", "alt", "cmd"}, "c"},
    ["com.tinyspeck.slackmacgap"]    = {{"ctrl", "alt", "cmd"}, "s"},
    ["us.zoom.xos"]                  = {{"ctrl", "alt", "cmd"}, "z"},
    [{
        "org.mozilla.firefoxdeveloperedition",
        "org.mozilla.firefox"}]     = {{"ctrl", "alt", "cmd"}, "f"},
})

--Mission ontrol
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "up", function()
    hs.application.launchOrFocus("Mission Control.app")
  end)

--App Switching
switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{})
hs.hotkey.bind('ctrl-alt-cmd', 'right', function() switcher_space:next() end)
hs.hotkey.bind('ctrl-alt-cmd', 'left', function() switcher_space:previous() end)
  
-- expose instances
expose = hs.expose.new(nil,{showThumbnails=false}) -- default windowfilter, no thumbnails
expose_space = hs.expose.new(nil,{includeOtherSpaces=false}) -- only windows in the current Mission Control Space
--expose_app = hs.expose.new(nil,{onlyActiveApplication=true}) -- show windows for the current application
--expose_browsers = hs.expose.new{'Firefox Developer Edition','Firefox'} -- specialized expose using a custom windowfilter

-- binding for expose
hs.hotkey.bind('ctrl-cmd-alt','space','Expose',function()expose:toggleShow()end)
hs.hotkey.bind('ctrl-cmd-alt','x','App Expose',function()expose_space:toggleShow()end)

-- window switcher
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Z", function()
    local currentWindow = hs.window.focusedWindow()
    local allWindows = hs.window.allWindows()

    local onScreenWindows = hs.fnutils.filter(allWindows, function(w)
        return w:screen() ~= nil
    end)

    if #onScreenWindows == 0 then return end
    
    if not currentWindow then
        -- focus the first window
        onScreenWindows[1]:focus()
        hs.alert.show(onScreenWindows[1]:title(), 2)
        return
    end

    -- Find current window index
    local currentIndex = hs.fnutils.indexOf(onScreenWindows, currentWindow)
    
    -- Get next window or wrap around
    local nextIndex = currentIndex and (currentIndex % #onScreenWindows) + 1 or 1
    local nextWindow = onScreenWindows[nextIndex]
    
    if nextWindow then
        nextWindow:focus()
        hs.alert.show(nextWindow:title(), 1)
    end
end)

-- Shift active window to space
local spaces = require("hs.spaces")

local function moveWindowToSpace(space)
    return function()
        local win = hs.window.focusedWindow()
        if not win then return end
        
        local screen = win:screen()
        local spaceID = spaces.allSpaces()[screen:getUUID()][space]
        
        if spaceID then
            spaces.moveWindowToSpace(win:id(), spaceID)
            spaces.gotoSpace(spaceID)  -- Follow window to new space
            hs.alert.show("Moved to Space " .. space, 1)
        end
    end
end

-- Bindings to move window to spaces 1-9
for i = 1, 9 do
    hs.hotkey.bind({"ctrl", "alt", "cmd"}, tostring(i), moveWindowToSpace(i))
end

-- move to next/previous space
function moveToSpace(direction)
    local spaces = hs.spaces.spacesForScreen()
    local currentSpace = hs.spaces.focusedSpace()
    local currentIndex = hs.fnutils.indexOf(spaces, currentSpace)
    local targetIndex
    
    if direction == "next" then
        targetIndex = (currentIndex % #spaces) + 1
    elseif direction == "previous" then
        targetIndex = ((currentIndex - 2) % #spaces) + 1
    else
        return
    end
    
    local targetSpace = spaces[targetIndex]
    hs.spaces.gotoSpace(targetSpace)
end
--Bindings
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "]", function() 
    moveToSpace("next")
end)
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "[", function() 
    moveToSpace("previous")
end)

local function queryOllama(prompt)
    local command = string.format([[curl -s http://localhost:11434/api/chat -d '{"model":"chrisllm","stream":false,"messages":[{"role":"user","content":"%s"}]}' | jq -r .message.content]], prompt)
    
    local task = hs.task.new("/bin/bash", function(exitCode, stdOut, stdErr)
        if exitCode == 0 and stdOut then
            -- Remove any quotes and newlines from the response
            local cleanResponse = string.gsub(stdOut, '["\n]', '')
            hs.alert.show(cleanResponse, {textSize = 11}, 5)
        else
            hs.alert.show("Error querying Ollama", 2)
        end
    end, {"-c", command})
    
    task:start()
end

--Get highlighted content
function getHighlightedContent()
    local originalPasteboard = hs.pasteboard.getContents()
    hs.eventtap.keyStroke({"cmd"}, "c")
    hs.timer.usleep(10000)
    local highlightedContent = hs.pasteboard.getContents()
    hs.pasteboard.setContents(originalPasteboard)
    print (highlightedContent)
    return highlightedContent
end

hs.hotkey.bind({"ctrl", "alt", "cmd"}, "q", function()
    -- this is a proof of concept for prompting local llm with highlighted content
    local highlightedContent = getHighlightedContent()
    print (highlightedContent)
    hs.alert.show("Thinking...", 1)
    local prompt = "Metaphors and synonyms: " .. highlightedContent
    queryOllama(prompt)
end)


