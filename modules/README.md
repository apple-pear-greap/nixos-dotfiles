# NixOS 系统模块

`core.nix` 仅静态导入各分组的 `default.nix`，主机只需导入 `core.nix`。

- `system/`：两台主机共享的基础策略（引导、Nix、语言、网络、工具、用户）。
- `desktop/`：X11 / Wayland、窗口管理器、输入法、音频、字体。
- `hardware/`：Intel / NVIDIA 图形、TLP 电源策略、蓝牙。
- `services/`：SSH 与 agenix 模块定义。
- `gaming/`：Steam、性能增强、AAGL 启动器。

## 主机选择

可选功能默认关闭，在 `host/<name>/configuration.nix` 中设置：

```nix
my.input.enable = true;
my.audio.enable = true;
my.fonts.enable = true;
my.bluetooth.enable = true;
my.ssh.enable = true;
my.graphics.intel.enable = true;
my.power = {
  enable = true;
  profile = "powersave"; # 或 "performance"
};
my.gaming = {
  enable = true;
  performance.enable = false;
  aagl.enable = false;
};
```

X11 / Wayland 沿用 `my.x11` 和 `my.wayland`，窗口管理器由 `wm` 选择。
游戏性能增强开启时会同时启用基础 Steam 配置。

开关控制本模块的配置贡献，并不强制禁止其他 NixOS 模块启用同一服务。
例如桌面模块也可能启用 PipeWire；`my.audio.enable = false` 不保证最终的
`services.pipewire.enable` 为 false。

`system.stateVersion`、充电阈值、设备路径、SSH 公钥等仍由主机维护。
NVIDIA 模块保留 desktop 的 PRIME / PCI / CachyOS 设置，并依赖该主机在
`flake.nix` 中导入 Chaotic；它不是适用于任意 NVIDIA 机器的通用配置。

移动文件后需要同步 Git 索引（包括删除旧路径和添加新路径），才能用 Git
flake 构建。无需为了重构创建提交。
