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
  font_size = 15,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  window_decorations = "INTEGRATED_BUTTONS|RESIZE|NONE",
  color_scheme = "Tokyo Night",
  window_background_opacity = 0.90,
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

  window_frame = {
    -- font = wezterm.font {},
  },
  leader = { key = "`", mods = "", timeout_milliseconds = 2000 },
  keys = {
    { key = "l", mods = "CMD|SHIFT",    action = act.ActivateTabRelative(1) },
    { key = "h", mods = "CMD|SHIFT",    action = act.ActivateTabRelative(-1) },
    { key = "j", mods = "CMD",          action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "CMD",          action = act.ActivatePaneDirection("Up") },
    { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "-", mods = "LEADER",       action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "R", mods = "SHIFT|CTRL",   action = act.ReloadConfiguration },
    { key = "X", mods = "CTRL|SHIFT",   action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
    { key = "W", mods = "CTRL|SHIFT",   action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
  },
}
