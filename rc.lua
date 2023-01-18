-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- {{{ Awful imports
require("awful.autofocus")
require("awful.hotkeys_popup.keys")
-- }}}

-- {{{ Autostart
require("config.autostart")
--}}}

-- {{{ Wallpaper
require("config.ui.wallpaper")
-- }}}

-- {{{ Error handling
require("config.error_handler")
-- }}}

-- {{{ Variable definitions
require("config.variables")
-- }}}

-- {{{ Layouts
require("config.layouts")
-- }}}

-- {{{ Menu
require("config.ui.mainmenu")
-- }}}

require("config.ui.bar")

-- Menubar configuration
require("config.menubar")
-- }}}

-- {{{ Mouse bindings
require("config.bindings.mouse")
-- }}}

-- {{{ Key bindings
require("config.bindings.keyboard")
-- }}}

-- {{{ Rules
require("config.rules")
-- }}}

-- {{{ Signals
require("config.signals")
-- }}}

-- {{{ Titlebar
require("config.ui.titlebar")
-- }}}

-- {{{ Popups
require("config.ui.popups")
-- }}}
