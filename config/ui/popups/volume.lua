local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local volume = wibox.widget({
  {
    {
      id     = "icon",
      text   = "",
      align  = 'center',
      valign = 'center',
      font   = "Ubuntu 72",
      widget = wibox.widget.textbox,
    },
    {
      id            = "pbar",
      value         = 0.0,
      forced_height = 15,
      forced_width  = 100,
      shape         = gears.shape.rounded_bar,
      widget        = wibox.widget.progressbar
    },
    layout = wibox.layout.fixed.vertical,
  },
  margins = 10,
  widget = wibox.container.margin
})

local popup = awful.popup {
  widget              = volume,
  ontop               = true,
  -- placement           = awful.placement.bottom,
  shape               = gears.shape.rounded_rect,
  visible             = false,
  hide_on_right_click = true,
}

awful.placement.bottom(popup, { offset = { x = -58, y = -135 } })

local timer = gears.timer {
  timeout = 1,
  autostart = false,
  callback = function ()
    popup.visible = false
  end,
}

awesome.connect_signal("signal::xf86audio", function(vol, mut)
  vol = tonumber(vol)

  if (vol == nil) then
    return
  end

  if (mut == "true" or vol == 0) then
    volume:get_children_by_id("icon")[1]:set_text("")
  elseif (vol <= 50) then
    volume:get_children_by_id("icon")[1]:set_text("")
  else
    volume:get_children_by_id("icon")[1]:set_text("")
  end

  volume:get_children_by_id("pbar")[1]:set_value(vol / 100)

  popup.visible = true
  timer:again()

end)
