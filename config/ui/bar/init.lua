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
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local right = wibox.widget {
  {
    volume,
    wifi,
    clock,
    spacing = 10,
    layout = wibox.layout.fixed.horizontal
  },
  right = 10,
  layout = wibox.container.margin
}

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end))

-- Bar
local function get_bar(s)

  awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])
  s.mytaglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all, buttons = taglist_buttons,
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen          = s,
    filter          = awful.widget.tasklist.filter.currenttags,
    buttons         = tasklist_buttons,
    layout          = {
      spacing_widget = {
        {
          forced_width  = 5,
          forced_height = 24,
          thickness     = 1,
          color         = '#0E1111',
          widget        = wibox.widget.separator
        },
        valign = 'center',
        halign = 'center',
        widget = wibox.container.place,
      },
      spacing        = 1,
      layout         = wibox.layout.fixed.horizontal
    },
    widget_template = {
      {
        wibox.widget.base.make_widget(),
        forced_height = 5,
        id            = 'background_role',
        widget        = wibox.container.background,
      },
      {
        {
          id     = 'clienticon',
          widget = awful.widget.clienticon,
        },
        margins = 5,
        widget  = wibox.container.margin
      },
      nil,
      create_callback = function(self, c, index, objects) --luacheck: no unused args
        self:get_children_by_id('clienticon')[1].client = c
      end,
      layout = wibox.layout.align.vertical,
    },
  }

  local tasklist = wibox.widget {
    {
      s.mytasklist,
      layout = wibox.layout.fixed.horizontal
    },
    left = 5,
    layout = wibox.container.margin
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
    screen = s
  })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.stack,
    {
      layout = wibox.layout.align.horizontal,
      left,
      nil,
      -- tasklist,
      right
    },
  }
end

awful.screen.connect_for_each_screen(function(s)
  get_bar(s)
end)
