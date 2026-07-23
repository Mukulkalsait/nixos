-- ~/.config/hypr/keybindings.lua
-- All keybindings in official Lua syntax

-- Variables (make sure these match your main config)

local mainMod = "SUPER"
local terminal = "ghostty" -- or "kitty"
-- local terminal = "kitty" -- Replace with your terminal (e.g., "ghostty")
local kterm = "kitty"
local browser = "zen-twilight" -- Replace with your browser
local editor = "nvim"
local filemanager = "yazi"
local taskmanager = "missioncenter"

-- -- ~/.config/hypr/keybindings.lua
-- local mainMod = "SUPER"
-- local terminal = "ghostty"
-- local kterm = "kitty"
-- local browser = "zen-twilight"
-- local editor = "nvim"
-- local filemanager = "yazi"
-- local taskmanager = "missioncenter"

local function setupKeybindings()
	-- Application Shortcuts
	hl.bind(mainMod .. " + " .. "Q", hl.dsp.window.close())
	hl.bind(mainMod .. " + " .. "I", hl.dsp.exec_cmd(terminal))
	hl.bind(mainMod .. " + " .. "C", hl.dsp.exec_cmd(kterm))
	hl.bind(mainMod .. " + " .. "B", hl.dsp.exec_cmd(browser))
	hl.bind(mainMod .. " + " .. "N", hl.dsp.exec_cmd(terminal .. " -e " .. editor))
	hl.bind(mainMod .. " + " .. "E", hl.dsp.exec_cmd(kterm .. " -e " .. filemanager))
	hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd(taskmanager))

	-- Scripts
	--

	local home = os.getenv("HOME")

	-- ======================================================================================================
	-- Floating scripts with parameters                                                                             G: Real files
	-- ======================================================================================================
	-- hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/floating_network1.sh"))
	-- hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/floating_network.sh"))
	-- hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/floating_audio.sh"))
	-- hl.bind(mainMod .. " + 8", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/floating_bluetooth.sh"))
	-- hl.bind(mainMod .. " + 8", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/floating_bluetooth.sh"))
	-- -- Passed arguments (toggle / resize)
	-- hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("sh -c '" .. home .. "/.config/hypr/scripts/floating_term.sh toggle'"))
	-- hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("sh -c '" .. home .. "/.config/hypr/scripts/floating_term.sh resize'"))

	-- ======================================================================================================
	-- Floating scripts with parameters                                                                             Y: TESTING
	-- ======================================================================================================
	hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(home .. "/.config/hypr/sc/floating_network1.sh"))
	hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(home .. "/.config/hypr/sc/floating_network.sh"))
	hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(home .. "/.config/hypr/sc/floating_audio.sh"))
	hl.bind(mainMod .. " + 8", hl.dsp.exec_cmd(home .. "/.config/hypr/sc/floating_bluetooth.sh"))
	hl.bind(mainMod .. " + 8", hl.dsp.exec_cmd(home .. "/.config/hypr/sc/floating_bluetooth.sh"))
	hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("sh -c '" .. home .. "/.config/hypr/sc/floating_term.sh toggle'"))
	hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("sh -c '" .. home .. "/.config/hypr/sc/floating_term.sh resize'"))
	-- ======================================================================================================

	-- Screen
	hl.bind(mainMod .. " + " .. "F", hl.dsp.window.fullscreen())
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "F", hl.dsp.window.float())

	-- Locking + Exit
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "0", hl.dsp.exit())
	hl.bind(mainMod .. " + " .. "0", hl.dsp.exec_cmd("dms ipc call lock lock"))

	-- DMS shortcuts
	hl.bind(mainMod .. " + " .. "SPACE", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
	hl.bind(mainMod .. " + " .. "PERIOD", hl.dsp.exec_cmd("dms ipc call settings toggle"))
	hl.bind(mainMod .. " + " .. "9", hl.dsp.exec_cmd("dms ipc call notifications toggle"))
	hl.bind(mainMod .. " + " .. "D", hl.dsp.exec_cmd("dms ipc call widget toggle clock"))
	hl.bind(mainMod .. " + " .. "U", hl.dsp.exec_cmd("dms ipc call control-center toggle"))
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "code:61", hl.dsp.exec_cmd("dms ipc call keybinds toggle hyprland")) -- # Keyboards Shortcuts : shift + (?) => key code 61
	hl.bind(mainMod .. " + " .. "code:51", hl.dsp.exec_cmd("dms ipc call widget toggle dankKDEConnect")) -- # Phone Connect : "web" (/) => key code: 51
	hl.bind(mainMod .. " + " .. "code:21", hl.dsp.exec_cmd("dms ipc call widget toggle battery")) -- # Battery Health : "wev"  (=)  => key code:21

	-- Wallpaper
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "W", hl.dsp.exec_cmd("dms ipc call wallpaper next"))

	-- Special Workspace
	hl.bind(mainMod .. " + " .. "S", hl.dsp.workspace.toggle_special("magic"))
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "S", hl.dsp.window.move({ workspace = "special:magic" }))

	-- Color Picker
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "P", hl.dsp.exec_cmd("hyprpicker -an"))

	-- Focus Movement
	hl.bind(mainMod .. " + " .. "H", hl.dsp.focus({ direction = "left" }))
	hl.bind(mainMod .. " + " .. "L", hl.dsp.focus({ direction = "right" }))
	hl.bind(mainMod .. " + " .. "K", hl.dsp.focus({ direction = "up" }))
	hl.bind(mainMod .. " + " .. "J", hl.dsp.focus({ direction = "down" }))

	-- Swap Windows
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "H", hl.dsp.window.swap({ direction = "left" }))
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "L", hl.dsp.window.swap({ direction = "right" }))
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "K", hl.dsp.window.swap({ direction = "up" }))
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "J", hl.dsp.window.swap({ direction = "down" }))

	-- Cycle Windows
	hl.bind("ALT" .. " + " .. "Tab", hl.dsp.window.cycle_next())

	-- Workspace Navigation
	hl.bind(mainMod .. " + CONTROL + 0", hl.dsp.focus({ workspace = "empty" })) -- navigtate to EMPTY SPACE NEARIST
	hl.bind(mainMod .. " + " .. "CTRL" .. " + " .. "L", hl.dsp.focus({ workspace = "r+1" }))
	hl.bind(mainMod .. " + " .. "CTRL" .. " + " .. "H", hl.dsp.focus({ workspace = "r-1" }))

	-- Drag windows (replace mainMod with your modifier if needed)
	hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
	hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

	-- Move Window to Workspace Y:
	--
	-- hl.bind(mainMod .. " + " .. "CTRL + SHIFT" .. " + " .. "L", hl.dsp.exec_cmd("hyprctl dispatch movetoworkspace r+1"))
	-- hl.bind(mainMod .. " + " .. "CTRL + SHIFT" .. " + " .. "H", hl.dsp.exec_cmd("hyprctl dispatch movetoworkspace r-1"))
	-- hl.bind(mainMod .. " + " .. "CTRL + SHIFT" .. " + " .. "L", hl.dsp.exec_cmd("movetoworkspace r+1"))
	-- hl.bind(mainMod .. " + " .. "CTRL + SHIFT" .. " + " .. "H", hl.dsp.exec_cmd("movetoworkspace r-1"))
	--
	-- Move active window to NEXT workspace (mainMod + SHIFT + CONTROL + L)
	hl.bind(mainMod .. " + SHIFT + CONTROL + L", hl.dsp.window.move({ workspace = "r+1" }))

	-- Move active window to PREVIOUS workspace (mainMod + SHIFT + CONTROL + H)
	hl.bind(mainMod .. " + SHIFT + CONTROL + H", hl.dsp.window.move({ workspace = "r-1" }))

	-- Move Group
	hl.bind(mainMod .. " + CONTROL + SHIFT + bracketright", hl.dsp.group.next({ forward = false }))
	hl.bind(mainMod .. " + CONTROL + SHIFT + bracketleft", hl.dsp.group.next())

	-- Move Windows to Workspaces (silent)
	-- hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 1, hl.dsp.window.move({ workspace = 1 }, { follow = false }))
	-- hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 2, hl.dsp.window.move({ workspace = 2 }, { follow = false }))
	-- hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 3, hl.dsp.window.move({ workspace = 3 }, { follow = false }))
	-- hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 4, hl.dsp.window.move({ workspace = 4 }, { follow = false }))
	-- hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 5, hl.dsp.window.move({ workspace = 5 }, { follow = false }))
	-- hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 6, hl.dsp.window.move({ workspace = 6 }, { follow = false }))
	-- hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 7, hl.dsp.window.move({ workspace = 7 }, { follow = false }))
	-- hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 8, hl.dsp.window.move({ workspace = 8 }, { follow = false }))
	-- hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 9, hl.dsp.window.move({ workspace = 9 }, { follow = false }))
	-- hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 0, hl.dsp.window.move({ workspace = 10 }, { follow = false }))

	-- Resize Windows
	hl.bind(mainMod .. " + ALT + H", hl.dsp.window.resize({ x = -30, y = 0, relative = true }))
	hl.bind(mainMod .. " + ALT + L", hl.dsp.window.resize({ x = 30, y = 0, relative = true }))
	hl.bind(mainMod .. " + ALT + K", hl.dsp.window.resize({ x = 0, y = -30, relative = true }))
	hl.bind(mainMod .. " + ALT + J", hl.dsp.window.resize({ x = 0, y = 30, relative = true }))

	-- Mouse bindings
	hl.bind(mainMod .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
	hl.bind(mainMod .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

	hl.bind(mainMod .. " + Z", hl.dsp.window.drag(), { mouse = true }) -- Press and hold Super + Z -> Window under cursor snaps to mouse and moves as you drag
	hl.bind(mainMod .. " + X", hl.dsp.window.resize(), { mouse = true }) -- Press and hold Super + X -> Drag mouse to resize the focused floating window

	-- Media Keys (locked = true for lock screen)
	hl.bind(
		"XF86AudioRaiseVolume",
		hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && ~/.config/swaync/scripts/volume_bar.sh"),
		{ locked = true }
	)
	hl.bind(
		"XF86AudioLowerVolume",
		hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && ~/.config/swaync/scripts/volume_bar.sh"),
		{ locked = true }
	)
	hl.bind(
		"XF86AudioMute",
		hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ~/.config/swaync/scripts/volume_bar.sh"),
		{ locked = true }
	)
	hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

	-- Brightness
	hl.bind(
		mainMod .. " + " .. "bracketright",
		hl.dsp.exec_cmd("brightnessctl s 10%+ && ~/.config/swaync/scripts/brightness_bar.sh"),
		{ locked = true }
	)
	hl.bind(
		mainMod .. " + " .. "bracketleft",
		hl.dsp.exec_cmd("brightnessctl s 10%- && ~/.config/swaync/scripts/brightness_bar.sh"),
		{ locked = true }
	)

	-- Media Playback
	hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
	hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
	hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
	hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

	-- Screenshot
	hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region -o ~/1_file/9_Pictures/Screenshots/"), { locked = true })
end

return {
	setup = setupKeybindings,
}
