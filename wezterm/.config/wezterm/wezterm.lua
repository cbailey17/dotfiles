-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	-- os.execute("bash -c zsh && cd")
	-- window:gui_window():maximize()
end)

return {
	font = wezterm.font_with_fallback({}),
	font_size = 10,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	window_decorations = "INTEGRATED_BUTTONS|RESIZE",
	color_scheme = "Tokyo Night",
	window_background_opacity = 0.90,
	hide_tab_bar_if_only_one_tab = false,
	use_dead_keys = false,
	default_prog = { "bash", "-c", "zsh" },
	font = wezterm.font_with_fallback({
		"JetBrains Mono",
		"Noto Sans Mono",
		"Noto Color Emoji",
	}),

	window_frame = {
		-- font = wezterm.font {},
	},
	leader = { key = "`", mods = "", timeout_milliseconds = 2000 },
	keys = {
		{ key = "l", mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },
		{ key = "h", mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
		{ key = "j", mods = "CMD", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "CMD", action = act.ActivatePaneDirection("Up") },
		{ key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "R", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
		{ key = "X", mods = "CTRL|SHIFT", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
		{ key = "W", mods = "CTRL|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
	},
}
