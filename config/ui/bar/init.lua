local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local dpi = beautiful.xresources.apply_dpi

-- Get widgets
local wifi = require("config.ui.bar.wifi")
local volume = require("config.ui.bar.volume")
local launcher = require("config.ui.bar.launcher")
local separator = require("config.ui.bar.separator")
local clock = require("config.ui.bar.clock")

local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

-- Bar
local function get_bar(s)
  awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.layouts[1])
  s.mytaglist = awful.widget.taglist {
      screen  = s,
      filter  = awful.widget.taglist.filter.all,
      buttons = taglist_buttons,
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
          launcher,
          s.mytaglist,
          spacing = 10,
          layout = wibox.layout.fixed.horizontal,
      },
      nil,
      { -- Right widgets
          volume,
          wifi,
          clock,
          spacing = 10,
          layout = wibox.layout.fixed.horizontal,
      },
  }
end

awful.screen.connect_for_each_screen(function(s)
	get_bar(s)
end)
