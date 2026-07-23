-- ~/.config/hypr/hyprland.lua

-- ==========================================
-- 1. OTHER FILES
-- ==========================================
local keybindings = require("keybindings")

-- ==========================================
-- 2. Monitor
-- ==========================================
hl.monitor({ output = "", mode = "1920x1200@165", position = "auto", scale = 1 })
hl.monitor({ output = "", mode = "3840x2160@120", position = "auto", scale = 1 })
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-- ==========================================
-- 3. Environment variables (from your working main.nix)
-- ==========================================
hl.env("NIXOS_OZONE_WL", "1")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SCREENSHOTS_DIR", os.getenv("HOME") .. "/screens")

-- ==========================================
-- 4. Main settings
-- ==========================================
hl.config({
	general = {
		gaps_in = 1,
		gaps_out = 1,
		border_size = 2,
		col = {
			-- Current active layout
			-- active_border = { colors = { "rgba(d65d0eff)", "rgba(98971aff)" }, angle = 90 }, -- orignal orange + green
			-- active_border = { colors = { "rgba(3d59ffff)", "rgba(b23dffff)" }, angle = 90 }, -- Most used
			-- active_border = { colors = { "rgba(3d59ffff)", "rgba(b23dffff)" }, angle = 90 }, -- 🧊 Blue–Purple Contrast (cool & futuristic)
			-- active_border = { colors = { "rgba(ff3366ff)", "rgba(ff66ccff)" }, angle = 90 }, -- ❤️‍🔥 Red–Magenta Energy (bold & vivid)
			-- active_border = { colors = { "rgba(ff63acff)", "rgba(c85affff)" }, angle = 90 }, -- 🌅 Pink–Purple Luxe (soft contrast)
			active_border = { colors = { "rgba(0078ffff)", "rgba(ff1e00ff)" }, angle = 90 }, -- -- 🧬 Electric Blue–Red Clash (high impact)
			inactive_border = "rgba(3c3836aa)",
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},
	dwindle = {
		preserve_split = false,
	},
	decoration = {
		rounding = 3,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = { enabled = false },
		blur = { enabled = false, size = 6, passes = 2 },
	},
	animations = {
		enabled = true,
	},
	-- Kebyoard
	input = {
		kb_layout = "us,in",
		repeat_delay = 250,
		repeat_rate = 60, --  repeats per second
		force_no_accel = 1,
		-- # kb_variant = "marathi";
		-- # kb_options = "ctrl:nocaps";
	},
	gestures = {
		-- # workspace_swipe = false;
		workspace_swipe_invert = false,
		workspace_swipe_forever = true,
	},
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = false,
		-- # force_default_amdgpu_renderer = false; # Y:NVIDIA compatibility
	},
	debug = {
		vfr = true,
	},
})

-- 1.

-- ==========================================
-- 5.Global Animation Switch
-- ==========================================
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } })
hl.curve("reBezier", { type = "bezier", points = { { 1, 0.99 }, { 0.48, 1.12 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 6, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "default" })

-- Fix for vertical bottom slide:
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 3, bezier = "myBezier", style = "slidefadevert" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 1.4, bezier = "reBezier", style = "slidefadevert" })

-- ==========================================
-- 6. Window rules
-- ==========================================
local float_apps = { "nmtui", "wiremix", "wifitui", "bluetooth", "floating_window" }
for _, app in ipairs(float_apps) do
	hl.window_rule({ match = { class = "^" .. app .. "$" }, float = true })
end

hl.window_rule({ name = "fullscreen_on", match = { class = "^(steam_app_[0-9]+)$" }, fullscreen = true }) -- B: 🎲 STEAM

-- ==========================================
-- 7. Workspace Rules (Smart Gaps)
-- ==========================================
hl.workspace_rule({ workspace = "w[tv1]", gaps_in = 0, gaps_out = 0 }) -- Remove screen margins completely if only ONE window is on the workspace
hl.workspace_rule({ workspace = "f[1]", gaps_in = 0, gaps_out = 0 }) -- Remove margins if a single window goes into a maximized frame format

-- ==========================================
-- 8. Autostart
-- ==========================================
--
hl.on("hyprland.start", function()
	hl.exec_cmd("dms run")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	-- hl.exec_cmd("while true; do ~/.config/hypr/scripts/battery-warning-dms.sh; sleep 60; done &")
	-- hl.exec_cmd("sh -c 'sleep 10; ~/.config/hypr/scripts/avatarchange.sh'")
end)

-- 9. Keybindings
keybindings.setup()
