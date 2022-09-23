local wibox = require("wibox")
local awful = require("awful")

local clock = wibox.widget({
  widget = wibox.widget.textclock,
  format = "%b %d %H:%M",
})

local month_calendar = awful.widget.calendar_popup.month()
month_calendar:attach( clock, "tc" )

return clock
