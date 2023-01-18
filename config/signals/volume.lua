local awful = require("awful")
local utils = require("utilities")

local current_volume = -1
local current_mute = false

local function emit_volume()
  awful.spawn.easy_async_with_shell(
    "pamixer --get-mute --get-volume",
    function(stdout)
      local chunks = {}
      for data in stdout:gmatch("%S+") do
        table.insert(chunks, data)
      end

      local mute = utils.toboolean(chunks[1])
      local volume = chunks[2]

      if volume ~= current_volume or mute ~= current_mute then
        awesome.emit_signal("signal::volume", volume, mute)
        current_volume = volume
        current_mute = mute
      end
    end)
end

emit_volume()

-- Sleeps until pactl detects an event (volume up/down/toggle mute)
local volume_script = [[
    bash -c "
    LANG=C pactl subscribe 2> /dev/null | grep --line-buffered \"Event 'change' on sink #\"
    "]]

-- Kill old pactl subscribe processes
awful.spawn.easy_async({
  "pkill", "--full", "--uid", os.getenv("USER"), "^pactl subscribe"
}, function()
  -- Run emit_volume_info() with each line printed
  awful.spawn.with_line_callback(volume_script, {
    stdout = function(line) emit_volume() end
  })
end)
