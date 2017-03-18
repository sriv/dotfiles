-----------------------------------------------
-- Set up
-----------------------------------------------

local mod = {"alt", "ctrl"}
spaces = require("hs._asm.undocumented.spaces")

hs.window.animationDuration = 0

function show_alert(message)
    hs.alert.show("Hammerspoon: " .. message) 
end

function create_spaces(n)
    for i=1,n-#spaces.query(spaces.allSpaces) do
        spaces.createSpace()
    end
end
-----------------------------------------------
-- Reload config on write
-----------------------------------------------

function reload_config(files)
    hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
show_alert("Config loaded")

-- WINDOW MANAGEMENT : Resizing

-----------------------------------------------
-- mod+d left one half window
-----------------------------------------------

hs.hotkey.bind(mod, 'd', function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x
        f.y = max.y
        f.w = max.w / 2
        f.h = max.h
        win:setFrame(f)
    else
        show_alert("No active window")
    end
end)

-----------------------------------------------
-- mod+g right one half window
-----------------------------------------------

hs.hotkey.bind(mod, 'g', function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x + (max.w / 2)
        f.y = max.y
        f.w = max.w / 2
        f.h = max.h
        win:setFrame(f)
    else
        show_alert("No active window")
    end
end)

-----------------------------------------------
-- mod+f max screen size
-----------------------------------------------

hs.hotkey.bind(mod, 'f', function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x
        f.y = max.y
        f.w = max.w
        f.h = max.h
        win:setFrame(f)
    else
        show_alert("No active window")
    end
end)

-----------------------------------------------
-- mod+i show window hints
-----------------------------------------------

hs.hotkey.bind(mod, 'i', function()
    hs.hints.windowHints()
end)

-- WINDOW MANAGEMENT : Focussing

--------------------------------------------------
-- mod+up,down,left,right to switch window focus
--------------------------------------------------
arrow_key_bindings = {
    up = function() hs.window.focusedWindow():focusWindowNorth() end,
    down = function() hs.window.focusedWindow():focusWindowSouth() end,
    left = function() hs.window.focusedWindow():focusWindowWest() end,
    right = function() hs.window.focusedWindow():focusWindowEast() end
}

for k, f in pairs(arrow_key_bindings) do
    hs.hotkey.bind(mod, k, function()
        if hs.window.focusedWindow() then
            f()
        else
            show_alert("No active window")
        end
    end)
end

create_spaces(4)
