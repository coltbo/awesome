local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local network = wibox.widget({
  layout = wibox.layout.align.horizontal,
  {
    id = "icon",
    text = "",
    align = "center",
    valign = "center",
    font = "FiraCode 20",
    widget = wibox.widget.textbox,
  },
})
local network_t = awful.tooltip {}


local function get_wifi()
	local script = [[
	nmcli g | tail -1 | awk '{printf $1}'
	]]

	awful.spawn.easy_async_with_shell(script, function(stdout)
		local status = tostring(stdout)
		if not status:match("disconnected") then
			local get_strength = [[
			awk '/^\s*w/ { print  int($3 * 100 / 70) }' /proc/net/wireless
			]]

			awful.spawn.easy_async_with_shell(get_strength, function(stdout)
				local strength = tonumber(stdout)
        network.icon:set_text("直")
        network_t.text = string.format("strength: %s", strength)
			end)
		else
      network.icon:set_text("直")
		end
	end)
end

gears.timer {
	timeout = 5,
	autostart = true,
	call_now = true,
	callback = function() get_wifi() end
}

network_t:add_to_object(network)

-- return network
return network
