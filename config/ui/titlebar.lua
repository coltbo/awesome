local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

client.connect_signal("request::titlebars", function(c)
  local titlebar = awful.titlebar(c, {
    size = 20
  })

  -- buttons for the titlebar
  local buttons = gears.table.join(
      awful.button({ }, 1, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.move(c)
      end),
      awful.button({ }, 3, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.resize(c)
      end)
  )

  titlebar : setup {
      { -- Left
          awful.titlebar.widget.maximizedbutton(c),
          awful.titlebar.widget.minimizebutton(c),
          awful.titlebar.widget.closebutton(c),
          layout = wibox.layout.fixed.horizontal,
      },
      { -- Middle
          buttons = buttons,
          layout  = wibox.layout.flex.horizontal
      },
      { -- Right
          buttons = buttons,
          layout = wibox.layout.fixed.horizontal()
      },
      layout = wibox.layout.align.horizontal,
  }
end)
