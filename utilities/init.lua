local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local beautiful = require("config.beautiful_loader")

local utils = {}

function utils.set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

function utils.toboolean(s)
  local bool = false
  if s == "true" then
    bool = true
  end
  return bool
end

function utils.signal_volume()
  awful.spawn.easy_async_with_shell(
    "pamixer --get-mute --get-volume",
    function(stdout)
      local chunks = {}
      for data in stdout:gmatch("%S+") do
        table.insert(chunks, data)
      end

      local mute = chunks[1]
      local volume = chunks[2]

      awesome.emit_signal("signal::xf86audio", volume, mute)
    end)
end

return utils
