local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = "/home/colten/.config/awesome/themes/"
local wallpaper_path = "/home/colten/Pictures/wallpapers/"

local gears = require("gears")

local theme = {}

theme.font          = "FiraCode 12"

-- {{{ Colors

theme.bg_normal     = "#1D1C1A"
theme.bg_focus      = "#26292C"
theme.bg_urgent     = "#D96C6C"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(0)
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

theme.black = "#323333"
theme.red = "#D96C6C"
theme.green = "#B5D96C"
theme.yellow = "#D9A36C"
theme.blue = "#6C90D9"
theme.magenta = "#B56CD9"
theme.pink = "#E8B2C0"
theme.white = "#E0DEDC"
theme.grey = "#3A3B3C"
theme.transparent = "#00000000"

theme.fg = "#33374c"

theme.bg = "#0E1111"
theme.bg_alt = "#E1E4E6"

-- }}}

-- {{{ taglist
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_spacing = 8
theme.taglist_disable_icon = true
theme.taglist_font = "Fira Code 10"
theme.taglist_bg_focus = theme.transparent
theme.taglist_fg_focus = "#7F9B64"
theme.taglist_fg_occupied = theme.white
theme.taglist_fg_empty = theme.grey
-- }}}

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- Define the image to load

-- {{{ Titlebar settings

theme.titlebar_close_button_normal = gears.color.recolor_image(themes_path .. "default/titlebar/close_1.png", theme.grey)
theme.titlebar_close_button_focus  = gears.color.recolor_image(themes_path .. "default/titlebar/close_2.png", theme.red)
theme.titlebar_minimize_button_normal = gears.color.recolor_image(themes_path .. "default/titlebar/minimize_1.png", theme.grey)
theme.titlebar_minimize_button_focus  = gears.color.recolor_image(themes_path .. "default/titlebar/minimize_2.png", theme.yellow)

theme.titlebar_maximized_button_normal_inactive = gears.color.recolor_image(themes_path .. "default/titlebar/close_1.png", theme.grey)
theme.titlebar_maximized_button_focus_inactive  = gears.color.recolor_image(themes_path .. "default/titlebar/close_1.png", theme.green)
theme.titlebar_maximized_button_normal_active = gears.color.recolor_image(themes_path .. "default/titlebar/close_1.png", theme.grey)
theme.titlebar_maximized_button_focus_active  = gears.color.recolor_image(themes_path .. "default/titlebar/close_1.png", theme.green)

theme.titlebar_bg_normal = gears.color("#26292C")
theme.titlebar_bg_focus = gears.color("#0E1111")

-- }}}

-- {{{ Wallpaper

theme.wallpaper = wallpaper_path.."pine1.jpg"

-- }}}

-- {{{ Layout icons 

theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- }}}

-- {{{ Awesome icon 

theme.awesome_icon = gears.color.recolor_image(themes_path .. "default/launchpad.png", theme.white)

-- }}}

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- {{{ wibar
-- theme.wibar_ontop = true
theme.wibar_type = "dock"
theme.wibar_height = 25
theme.wibar_bg = theme.bg
-- }}}



return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
