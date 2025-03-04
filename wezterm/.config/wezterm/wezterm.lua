-- Pull in the wezterm API
local wezterm = require("wezterm")
-- local mux = wezterm.mux

local act = wezterm.action

return {
	colors = {
		foreground = "#CBE0F0",
		background = "#011423",
		cursor_bg = "#47FF9C",
		cursor_border = "#47FF9C",
		cursor_fg = "#011423",
		selection_bg = "#706b4e",
		selection_fg = "#f3d9c4",
		ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
		brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
	},
	front_end = "Software",
	font_size = 11,
	use_fancy_tab_bar = false,
	enable_scroll_bar = false,
	tab_bar_at_bottom = true,
	window_decorations = "INTEGRATED_BUTTONS|RESIZE",
	color_scheme = "Tokyo Night",
	window_background_opacity = 0.80,
	hide_tab_bar_if_only_one_tab = false,
	macos_window_background_blur = 8,
	use_dead_keys = false,
	default_prog = { "bash", "-c", "zsh" },
	font = wezterm.font_with_fallback({
		"ComicShannsMono Nerd Font",
		"JetBrains Mono",
		"Noto Sans Mono",
		"Noto Color Emoji",
	}),

	leader = { key = "a", mods = "CTRL|SHIFT", timeout_milliseconds = 2000 },
	keys = {
		{ key = "l", mods = "ALT|SHIFT", action = act.ActivateTabRelative(1) },
		{ key = "h", mods = "ALT|SHIFT", action = act.ActivateTabRelative(-1) },
		{ key = "j", mods = "CMD", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "CMD", action = act.ActivatePaneDirection("Up") },
		{ key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "R", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
		{ key = "X", mods = "CTRL|SHIFT", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
		{ key = "W", mods = "CTRL|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = wezterm.action({
				SpawnCommandInNewTab = {
					args = { "zsh", "-c", "ls" },
				},
			}),
		},
		{
			key = "1",
			mods = "CTRL",
			action = wezterm.action.ActivateTab(0),
		},
		{
			key = "2",
			mods = "CTRL",
			action = wezterm.action.ActivateTab(1),
		},
		{
			key = "3",
			mods = "CTRL",
			action = wezterm.action.ActivateTab(2),
		},
	},
}
