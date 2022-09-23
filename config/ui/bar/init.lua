local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Get widgets
local wifi = require("config.ui.bar.wifi")
local volume = require("config.ui.bar.volume")
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

local right = wibox.widget {
  {
    volume,
    wifi,
    spacing = 10,
    layout = wibox.layout.fixed.horizontal
  },
  right = 10,
  layout = wibox.container.margin
}

-- Bar
local function get_bar(s)

  awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])
  s.mytaglist = awful.widget.taglist {
      screen  = s,
      filter  = awful.widget.taglist.filter.all,
      buttons = taglist_buttons,
  }

  local left = wibox.widget {
    {
      s.mytaglist,
      layout = wibox.layout.fixed.horizontal
    },
    left = 10,
    layout = wibox.container.margin
  }

  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "top",
    visible = true,
    screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
      layout = wibox.layout.stack,
      {
          layout = wibox.layout.align.horizontal,
          left,
          nil,
          right
      },
      {
          clock,
          valign = "center",
          halign = "center",
          layout = wibox.container.place
      }
  }
end

awful.screen.connect_for_each_screen(function(s)
	get_bar(s)
end)
