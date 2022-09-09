local beautiful = require("config.beautiful_loader")
local awful = require("awful")

local launcher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                         menu = mymainmenu })

return launcher
