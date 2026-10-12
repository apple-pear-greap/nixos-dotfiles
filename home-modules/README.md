# Home Manager 模块

`core.nix` 只导入各分组目录，由对应的 `default.nix` 汇总模块。
主机入口为 `host/<name>/home.nix`，两台机器都只需导入 `core.nix`。

| 目录 | 职责 |
| --- | --- |
| `base/` | 用户信息、XDG 目录、agenix 与仓库软链接辅助模块 |
| `cli/` | 命令行工具、Bash / Starship / FZF、Git、NNN |
| `development/` | 编译工具、语言服务器、AI 工具 |
| `editors/` | Neovim、Emacs、LaTeX / Zathura |
| `browsers/` | Firefox、Helium、LibreWolf |
| `desktop/` | 桌面工具、Rofi、X11 / Wayland、WM、音频切换与通知 |
| `terminals/` | Kitty、tmux、Foot 配置链接 |
| `media/` | 可选 MPV 播放器 |

公共应用保持重组前的启用行为。可选功能由主机设置：

```nix
my.hm.kitty.enable = true;
my.hm.mpv.enable = false; # 默认关闭
my.hm.spotify.enable = false; # 默认关闭
my.hm.wayland = {
  enable = true;
  wm = "niri";
};
my.hm.x11.enable = false;
```

X11 / DWM 主机选择 `my.hm.x11`；通知在 Wayland 下使用 Mako，
仅启用 X11 时使用 Dunst。

`home.stateVersion` 留在各自主机入口，不应随发行版版本自动更新。
主机专属的软件包、环境变量和浏览器选择仍由主机维护。

原生配置通过 `config.my.xdg.creatSymlink` 链接到
`~/nixos-config/config/<应用>`；编辑器、终端和 Rofi 的链接由各自模块管理。
跨目录引用脚本、secret 和 suckless 源码时，需要按模块所在深度调整路径。

迁移后须同步 Git 索引中的旧路径和新路径，才能通过 Git flake 构建：

```sh
git add -A home-modules host/desktop/home.nix host/mobile/home.nix
```
