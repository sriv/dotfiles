-----------------------------------------------
-- Set up
-----------------------------------------------

local hyper = {"cmd", "alt", "ctrl"}
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

-- WINDOW MANAGEMENT

-----------------------------------------------
-- hyper+d left one half window
-----------------------------------------------

hs.hotkey.bind(hyper, 'd', function()
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
-- hyper+g right one half window
-----------------------------------------------

hs.hotkey.bind(hyper, 'g', function()
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
-- hyper+f max screen size
-----------------------------------------------

hs.hotkey.bind(hyper, 'f', function()
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
-- hyper+i show window hints
-----------------------------------------------

hs.hotkey.bind(hyper, 'i', function()
    hs.hints.windowHints()
end)

create_spaces(4)
