PaperWM = hs.loadSpoon("PaperWM")
PaperWM:bindHotkeys({
    -- switch to a new focused window in tiled grid
    --focus_left  = {{"ctrl", "alt", "cmd"}, "left"},
    --focus_right = {{"ctrl", "alt", "cmd"}, "right"},
    --focus_up    = {{"ctrl", "alt", "cmd"}, "up"},
    --focus_down  = {{"ctrl", "alt", "cmd"}, "down"},
     
    -- move windows around in tiled grid
    --swap_left  = {{"ctrl", "alt", "cmd"}, ","},
    --swap_right = {{"ctrl", "alt", "cmd"}, "."},
    --swap_up    = {{"ctrl", "alt", "cmd"}, "'"},
    --swap_down  = {{"ctrl", "alt", "cmd"}, "/"},

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

    -- CC
    switch_space_l       = { { "ctrl", "alt", "cmd" }, "left" },
    switch_space_r       = { { "ctrl", "alt", "cmd" }, "right" },
     
})
PaperWM.window_ratios = { 0.36, 0.64, 0.8, 0.95 }
PaperWM:start()

-- App Switcher
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

-- Define app shortcuts
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
