-- ~/.config/hypr/keybindings.lua

local mainMod = "SUPER"

-- NOTE: ========================================================
-- change into /hosts/apps/sessionPath_n_Variables.nix
-- ==============================================================
--
-- Y: Main => Ghostty
local terminal = "ghostty"
local kterm = "kitty"

-- Y: Main => Kitty
-- local terminal = "kitty"
-- local kterm = "ghostty"
-- ==============================================================

local browser = "zen-twilight" -- Replace with your browser
local editor = "nvim"
local filemanager = "yazi"
local taskmanager = "missioncenter"

local function setupKeybindings()
	-- Application Shortcuts
	hl.bind(mainMod .. " + " .. "Q", hl.dsp.window.close(), "Quit Window")
	hl.bind(mainMod .. " + " .. "I", hl.dsp.exec_cmd(terminal), "Ghostty")
	hl.bind(mainMod .. " + " .. "C", hl.dsp.exec_cmd(kterm), "Kitty")
	hl.bind(mainMod .. " + " .. "B", hl.dsp.exec_cmd(browser), "zen-twilight")
	hl.bind(mainMod .. " + " .. "N", hl.dsp.exec_cmd(terminal .. " -e " .. editor), "Neovim-Editor")
	hl.bind(mainMod .. " + " .. "E", hl.dsp.exec_cmd(kterm .. " -e " .. filemanager), "FileManager Yazi")
	hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd(taskmanager), "MissionCenter")

	local home = os.getenv("HOME")

	-- ======================================================================================================
	-- Floating scripts with parameters                                                                             G: Real files
	-- ======================================================================================================
	local dir = home .. "/.config/hypr/scripts/" -- Y: variable for location os scripts

	hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(dir .. "floating_network.sh"), "Network Manger")
	hl.bind(mainMod .. " + " .. "W", hl.dsp.exec_cmd(dir .. "floating_network1.sh"), "Wifi-Tui")
	hl.bind(mainMod .. " + " .. "A", hl.dsp.exec_cmd(dir .. "floating_audio.sh"), "WireMix")
	hl.bind(mainMod .. " + " .. "8", hl.dsp.exec_cmd(dir .. "floating_bluetooth.sh"), "👖 BlueTui-Tooth")

	hl.bind(
		mainMod .. " + " .. "P",
		hl.dsp.exec_cmd("sh -c '" .. dir .. "floating_term.sh toggle'"),
		"Floating Kitty + TT"
	)
	hl.bind(
		mainMod .. " + " .. "R",
		hl.dsp.exec_cmd("sh -c '" .. dir .. "floating_term.sh resize'"),
		"Floating Kitty Resize"
	)
	-- ======================================================================================================

	-- Screen
	hl.bind(mainMod .. " + " .. "F", hl.dsp.window.fullscreen(), "🪟 Window-Toggle FULLSCREEN")
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "F", hl.dsp.window.float(), "🪟 Window-Toggle FLOATING")

	-- Locking + Exit
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "0", hl.dsp.exit(), "HYPRLAND EXIT")
	hl.bind(mainMod .. " + " .. "0", hl.dsp.exec_cmd("noctalia msg session lock"), "Lock Screen")
	-- hl.bind(mainMod .. " + " .. "0", hl.dsp.exec_cmd("dms ipc call lock lock"))
	--

	-- B: DMS shortcuts
	-- hl.bind(mainMod .. " + " .. "SPACE", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
	-- hl.bind(mainMod .. " + " .. "PERIOD", hl.dsp.exec_cmd("dms ipc call settings toggle"))
	-- hl.bind(mainMod .. " + " .. "9", hl.dsp.exec_cmd("dms ipc call notifications toggle"))
	-- hl.bind(mainMod .. " + " .. "U", hl.dsp.exec_cmd("dms ipc call control-center toggle"))
	-- hl.bind(mainMod .. " + " .. "D", hl.dsp.exec_cmd("dms ipc call widget toggle clock"))
	-- hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "code:61", hl.dsp.exec_cmd("dms ipc call keybinds toggle hyprland")) -- # Keyboards Shortcuts : shift + (?) => key code 61
	-- hl.bind(mainMod .. " + " .. "code:51", hl.dsp.exec_cmd("dms ipc call widget toggle dankKDEConnect")) -- # Phone Connect : "web" (/) => key code: 51
	-- hl.bind(mainMod .. " + " .. "code:21", hl.dsp.exec_cmd("dms ipc call widget toggle battery")) -- # Battery Health : "wev"  (=)  => key code:21
	-- hl.bind(mainMod .. " + " .. "D", hl.dsp.exec_cmd("dms ipc call widget toggle clock"))
	-- hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "W", hl.dsp.exec_cmd("dms ipc call wallpaper next"))

	-- B: noctalia shortcuts
	local n_msg = "noctalia msg"
	local pt = n_msg .. " panel-toggle"
	-- local cheat_sheet = " kenn/keybind-cheatsheet:cheatsheet"
	local cheat_sheet = " blackbartblues/keymap:panel"

	hl.bind(mainMod .. " + " .. "SPACE", hl.dsp.exec_cmd(pt .. " launcher"), "App Launcher")
	hl.bind(mainMod .. " + " .. "PERIOD", hl.dsp.exec_cmd(n_msg .. " settings-toggle"), "Settings")
	hl.bind(mainMod .. " + " .. "9", hl.dsp.exec_cmd(pt .. " control-center notifications"), "Notifications")
	hl.bind(mainMod .. " + " .. "1", hl.dsp.exec_cmd(pt .. " wallpaper"), "Walpaper Selector")
	hl.bind(mainMod .. " + " .. "U", hl.dsp.exec_cmd(pt .. " control-center"), "OverView")
	hl.bind(mainMod .. " + " .. "D", hl.dsp.exec_cmd(pt .. " avivbintangaringga/nix-monitor:panel"), "Nix-Menu")
	hl.bind(mainMod .. " + " .. "T", hl.dsp.exec_cmd(pt .. " davemhammer/tailscale:manager"), "Tailscale-Menu")
	-- hl.bind(mainMod .. " + " .. "D", hl.dsp.exec_cmd(pt .. " control-center calendar"))

	-- noctalia msg panel-toggle

	hl.bind(mainMod .. " + " .. "code:47", hl.dsp.exec_cmd(pt .. " liamwh/emoji-picker:wide"), "Emoji Selector") -- # new key for emojies
	hl.bind(mainMod .. " + " .. "code:51", hl.dsp.exec_cmd(pt .. " icefish/phone-connect:details"), "KDE-Connect") -- # Phone Connect : "web" (/) => key code: 51
	hl.bind(mainMod .. " + " .. "code:21", hl.dsp.exec_cmd(pt .. " control-center power"), "Battery") -- # Battery Health : "wev"  (=)  => key code:21
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "code:61", hl.dsp.exec_cmd(pt .. cheat_sheet), "KeyBindings") -- # Keyboards Shortcuts : shift + (?) => key code 61

	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "W", hl.dsp.exec_cmd(n_msg .. " wallpaper-next"), "NextWalpaper")
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "C", hl.dsp.exec_cmd(pt .. " clipboard"), "Clipboard Selector")

	-- Special Workspace
	hl.bind(mainMod .. " + " .. "S", hl.dsp.workspace.toggle_special("magic"), "Special Space")
	hl.bind(
		mainMod .. " + " .. "SHIFT" .. " + " .. "S",
		hl.dsp.window.move({ workspace = "special:magic" }),
		"🪟 Window-Move SpecialSpace"
	)

	-- Color Picker
	hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "P", hl.dsp.exec_cmd("hyprpicker -an"), "Hypre-ColorPicker")

	-- Focus Movement
	hl.bind(mainMod .. " + " .. "H", hl.dsp.focus({ direction = "left" }), "🪟 Window-Focus Left")
	hl.bind(mainMod .. " + " .. "L", hl.dsp.focus({ direction = "right" }), "🪟 Window-Focus Right")
	hl.bind(mainMod .. " + " .. "K", hl.dsp.focus({ direction = "up" }), "🪟 Window-Focus Up")
	hl.bind(mainMod .. " + " .. "J", hl.dsp.focus({ direction = "down" }), "🪟 Window-Focus Down")

	-- Swap Windows
	hl.bind(
		mainMod .. " + " .. "SHIFT" .. " + " .. "H",
		hl.dsp.window.swap({ direction = "left" }),
		"🪟 Window Swap Left"
	)
	hl.bind(
		mainMod .. " + " .. "SHIFT" .. " + " .. "L",
		hl.dsp.window.swap({ direction = "right" }),
		"🪟 Window Swap Right"
	)
	hl.bind(
		mainMod .. " + " .. "SHIFT" .. " + " .. "K",
		hl.dsp.window.swap({ direction = "up" }),
		"🪟 Window Swap Up"
	)
	hl.bind(
		mainMod .. " + " .. "SHIFT" .. " + " .. "J",
		hl.dsp.window.swap({ direction = "down" }),
		"🪟 Window Swap Down"
	)

	-- Cycle Windows
	hl.bind("ALT" .. " + " .. "Tab", hl.dsp.window.cycle_next(), "Window Focus Cycle")

	-- Workspace Navigation
	hl.bind(mainMod .. " + CONTROL + 0", hl.dsp.focus({ workspace = "empty" }), "Open Closest Clean Worsspace") -- navigtate to EMPTY SPACE NEARIST
	hl.bind(mainMod .. " + " .. "CTRL" .. " + " .. "H", hl.dsp.focus({ workspace = "r-1" }), "Workspace Swithc Left")
	hl.bind(mainMod .. " + " .. "CTRL" .. " + " .. "L", hl.dsp.focus({ workspace = "r+1" }), "Workspace Switch Right")

	-- Move Window to Workspace Y:
	--
	-- hl.bind(mainMod .. " + " .. "CTRL + SHIFT" .. " + " .. "L", hl.dsp.exec_cmd("hyprctl dispatch movetoworkspace r+1"))
	-- hl.bind(mainMod .. " + " .. "CTRL + SHIFT" .. " + " .. "H", hl.dsp.exec_cmd("hyprctl dispatch movetoworkspace r-1"))
	-- hl.bind(mainMod .. " + " .. "CTRL + SHIFT" .. " + " .. "L", hl.dsp.exec_cmd("movetoworkspace r+1"))
	-- hl.bind(mainMod .. " + " .. "CTRL + SHIFT" .. " + " .. "H", hl.dsp.exec_cmd("movetoworkspace r-1"))
	--
	-- Move active window to NEXT workspace (mainMod + SHIFT + CONTROL + L)
	hl.bind(
		mainMod .. " + SHIFT + CONTROL + L",
		hl.dsp.window.move({ workspace = "r+1" }),
		"🪟 Window-Workspace Move Right"
	)

	-- Move active window to PREVIOUS workspace (mainMod + SHIFT + CONTROL + H)
	hl.bind(
		mainMod .. " + SHIFT + CONTROL + H",
		hl.dsp.window.move({ workspace = "r-1" }),
		"🪟 Window-Workspace Move Left"
	)

	-- Move Group
	hl.bind(
		mainMod .. " + CONTROL + SHIFT + bracketright",
		hl.dsp.group.next({ forward = false }),
		"Window Group-Workspace Move Right"
	)
	hl.bind(mainMod .. " + CONTROL + SHIFT + bracketleft", hl.dsp.group.next(), "Window Group-Workspace Move Left")

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
	hl.bind(mainMod .. " + ALT + H", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), "Window-Resize Left")
	hl.bind(mainMod .. " + ALT + L", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), "Window-Resize Right")
	hl.bind(mainMod .. " + ALT + K", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), "Window-Resize Up")
	hl.bind(mainMod .. " + ALT + J", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), "Window-Resize Down")

	-- Drag windows (replace mainMod with your modifier if needed) Mouse bindings
	hl.bind(mainMod .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true }, "Drag Window")
	hl.bind(mainMod .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true }, "Resize Window")

	hl.bind(mainMod .. " + Z", hl.dsp.window.drag(), { mouse = true }, "Window-Follow-Cursor") -- Press and hold Super + Z -> Window under cursor snaps to mouse and moves as you drag
	hl.bind(mainMod .. " + X", hl.dsp.window.resize(), { mouse = true }, "Window-Resize-Cursor") -- Press and hold Super + X -> Drag mouse to resize the focused floating window

	-- Media Keys (locked = true for lock screen)
	hl.bind(
		"XF86AudioRaiseVolume",
		hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && ~/.config/swaync/scripts/volume_bar.sh"),
		{ locked = true },
		"Volume Up"
	)
	hl.bind(
		"XF86AudioLowerVolume",
		hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && ~/.config/swaync/scripts/volume_bar.sh"),
		{ locked = true },
		"Volume Down"
	)
	hl.bind(
		"XF86AudioMute",
		hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ~/.config/swaync/scripts/volume_bar.sh"),
		{ locked = true },
		"Mute"
	)
	hl.bind(
		"XF86AudioMicMute",
		hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
		{ locked = true },
		"Mice Mute"
	)

	-- Brightness
	hl.bind(
		mainMod .. " + " .. "bracketright",
		hl.dsp.exec_cmd("brightnessctl s 10%+ && ~/.config/swaync/scripts/brightness_bar.sh"),
		{ locked = true },
		"Brightness Up"
	)
	hl.bind(
		mainMod .. " + " .. "bracketleft",
		hl.dsp.exec_cmd("brightnessctl s 10%- && ~/.config/swaync/scripts/brightness_bar.sh"),
		{ locked = true },
		"Brightness Down"
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
