-----------------------------------------------
-- Set up
-----------------------------------------------

local hyper = {"shift","alt"}

hs.window.animationDuration = 0

function show_alert(message)
    hs.alert.show("Hammerspoon: " .. message) 
end

-----------------------------------------------
-- Reload config on write
-----------------------------------------------

function reload_config(files)
    hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
show_alert("Config loaded")
