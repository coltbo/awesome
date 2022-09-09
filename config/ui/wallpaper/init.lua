local awful = require("awful")
local wibox = require("wibox")
local utils = require("utilities")

screen.connect_signal("property::geometry", utils.set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  utils.set_wallpaper(s)
end)
