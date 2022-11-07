local awful = require("awful")
local wibox = require("wibox")
local utils = require("utilities")

local volume = wibox.widget.textbox()
local volume_t = awful.tooltip {}

volume.font = "FiraCode 20"

-- handle volume signals
awesome.connect_signal("signal::volume", function (vol, mute)
  vol = tonumber(vol)
  mute = utils.toboolean(mute)

  if (vol == nil) then
    return
  end

  volume_t.text = string.format("volume: %s", vol)

  if mute == true or vol == 0 then
    volume.markup = "婢"
  else
    if vol < 50 then
      volume.markup = "奔"
    else
      volume.markup = "墳"
    end
  end
end)

-- add tooltip to volume widget
volume_t:add_to_object(volume)

return volume
