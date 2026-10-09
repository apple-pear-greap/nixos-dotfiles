-- Set programs that you use
local terminal    = "footclient"
local fileManager = "dolphin"
local menu        = "rofi -show drun"
local mainMod     = "SUPER" -- Sets "Windows" key as main modifier
local vim_binding = { left = 'h', right = 'l', up = 'k', down = 'j' }

hl.bind("SUPER + tab", function()
  local layouts   = { "scrolling", "dwindle", "master", "monocle" }
  local workspace = hl.get_active_workspace()
  if hl.get_active_special_workspace() then
    workspace = hl.get_active_special_workspace()
  end

  local next_layout = "dwindle"

  if not workspace then
    return
  end

  for i = 1, #layouts do
    if layouts[i] == workspace.tiled_layout then
      local next_layout_idx = (i % #layouts) + 1
      next_layout = layouts[next_layout_idx]
      break
    end
  end

  if workspace.special then
    hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
  else
    hl.workspace_rule({ workspace = "name:" .. tostring(workspace.name), layout = next_layout })
  end
end)

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + Q",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd("/home/yuan/nixos-config/config/waybar/waybar-launcher.sh"))
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd('grim -o "HDMI-A-3" ~/Pictures/Screenshots/$(date +%F-%H_%M_%S)-window.png'))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"))

-- use this to idle secondary screen
hl.bind(mainMod .. " + CTRL + I", function()
  hl.timer(function()
    hl.dispatch(hl.dsp.dpms({ monitor = "eDP-1", action = "disable" }))
  end, { timeout = 500, type = "oneshot" })
end)

hl.bind(mainMod .. " + SHIFT + I", function()
  hl.timer(function()
    hl.dispatch(hl.dsp.dpms({ monitor = "eDP-1", action = "able" }))
  end, { timeout = 500, type = "oneshot" })
end)

-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

hl.bind(mainMod .. " + W", hl.dsp.group.toggle())
hl.bind(mainMod .. " + U", hl.dsp.group.prev())
hl.bind(mainMod .. " + I", hl.dsp.group.next())

for key, value in pairs(vim_binding) do
  hl.bind(mainMod .. " + " .. value, hl.dsp.focus({ direction = key }))
  hl.bind(mainMod .. " + SHIFT + " .. value, hl.dsp.window.swap({ direction = key }))
end

for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + CTRL + " .. "L", hl.dsp.window.resize({ y = 0, x = 10, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + " .. "H", hl.dsp.window.resize({ y = 0, x = -10, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + " .. "J", hl.dsp.window.resize({ y = 10, x = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + " .. "K", hl.dsp.window.resize({ y = -10, x = 0, relative = true }), { repeating = true })

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "m-1" }))

hl.bind(mainMod .. " + N", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + P", hl.dsp.focus({ workspace = "m-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
