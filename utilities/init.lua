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

return utils
