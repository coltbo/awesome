local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

-- Wifi
local wifi = wibox.widget.textbox()
local wifi_t = awful.tooltip {}

wifi.font = "FiraCode 14"

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
        wifi.markup = "直"
        wifi_t.text = string.format("strength: %s", strength)
			end)
		else
			wifi.markup = "睊"
		end
	end)
end

gears.timer {
	timeout = 5,
	autostart = true,
	call_now = true,
	callback = function() get_wifi() end
}

wifi_t:add_to_object(wifi)

return wifi
