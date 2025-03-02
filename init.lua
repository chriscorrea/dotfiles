PaperWM = hs.loadSpoon("PaperWM")
local spaces = require("hs.spaces")

PaperWM:bindHotkeys({
    -- colemak keybindings for home/upper row navigation
    focus_left = {{"ctrl", "alt", "cmd"}, "n"},
    focus_right = {{"ctrl", "alt", "cmd"}, "e"},
    focus_up = {{"ctrl", "alt", "cmd"}, "l"},
    focus_down = {{"ctrl", "alt", "cmd"}, "m"},
    
    swap_left = {{"ctrl", "alt", "cmd"}, "i"},
    swap_right = {{"ctrl", "alt", "cmd"}, "o"},
    swap_up = {{"ctrl", "alt", "cmd"}, "u"},
    swap_down = {{"ctrl", "alt", "cmd"}, ","},

    -- position and resize focused window 
    center_window = {{"ctrl", "alt", "cmd"}, "c"},
    full_width    = {{"ctrl", "alt", "cmd"}, "v"},
    cycle_width   = {{"ctrl", "alt", "cmd"}, "h"},
    cycle_height  = {{"ctrl", "alt", "cmd"}, "j"},

    reverse_cycle_width  = {{"ctrl", "alt", "cmd"}, "d"},
    reverse_cycle_height = {{"ctrl", "alt", "cmd"}, "g"},

    -- move focused window into / out of a column
    slurp_in = {{"ctrl", "alt", "cmd"}, "9"},
    barf_out = {{"ctrl", "alt", "cmd"}, "0"},

    -- switch to a new Mission Control space
    switch_space_1 = {{"ctrl", "alt", "cmd"}, "1"},
    switch_space_2 = {{"ctrl", "alt", "cmd"}, "2"},
    switch_space_3 = {{"ctrl", "alt", "cmd"}, "3"},
    switch_space_4 = {{"ctrl", "alt", "cmd"}, "4"},
    switch_space_5 = {{"ctrl", "alt", "cmd"}, "5"},
    switch_space_6 = {{"ctrl", "alt", "cmd"}, "6"},

    -- move focused window to a new space and tile
    move_window_1 = {{"ctrl", "alt", "cmd", "shift"}, "1"},
    move_window_2 = {{"ctrl", "alt", "cmd", "shift"}, "2"},
    move_window_3 = {{"ctrl", "alt", "cmd", "shift"}, "3"},
    move_window_4 = {{"ctrl", "alt", "cmd", "shift"}, "4"},
    move_window_5 = {{"ctrl", "alt", "cmd", "shift"}, "5"},
    move_window_6 = {{"ctrl", "alt", "cmd", "shift"}, "6"},

    -- mission control functions
    expose = {{"ctrl", "alt", "cmd"}, "space"},
    expose_all = {{"ctrl", "alt", "cmd"}, "tab"},

    -- CC
    switch_space_l       = { { "ctrl", "alt", "cmd" }, "left" },
    switch_space_r       = { { "ctrl", "alt", "cmd" }, "right" },
     
})
PaperWM.window_ratios = { 0.36, 0.5, 0.64, 0.9 }
PaperWM:start()

-- App Launch
local function launch(bundleID, appName)
    local app = hs.application.get(bundleID)
    if app then
        app:activate()
    else
        -- Try launching by bundle ID first
        local succeeded = hs.application.launchOrFocusByBundleID(bundleID)
        if not succeeded then
            -- Fallback to launching by app name
            hs.application.launchOrFocus(appName)
        end
    end
end

-- Define app launch shortcuts
hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "V", function() 
    launch("com.microsoft.VSCode", "Visual Studio Code")
end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "T", function() 
    launch("com.googlecode.iterm2", "iTerm")
end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "S", function() 
    launch("com.slack.Slack", "Slack")
end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "F", function() 
    launch("org.mozilla.firefox", "Firefox", "Firefox Developer Edition")
end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "A", function() 
    launch("com.anytype.Anytype", "AnyType")
end)

-- Spaces Controls
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "up", function() 
    spaces.toggleMissionControl()
end)

local spaces = require("hs.spaces")

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
    local prompt = "Write a single sentence response to this content: " .. highlightedContent
    queryOllama(prompt)
end)

-- Window hints to shift focus via keyboard shortcut
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "space", function()
    hs.hints.windowHints()
end) 

