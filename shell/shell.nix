{ config, pkgs, ...}:
{
    programs.zsh = {
    enable = true;

    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    shellAliases = {
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      gs = "git status";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#$(hostname)";
      cat = "bat";
    };

    initContent = ''
      fastfetch

      export ZCOMPDUMP="''${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump"
      mkdir -p "''${ZCOMPDUMP%/*}"
      autoload -Uz compinit
      compinit -C -d "$ZCOMPDUMP"

    '';
  };

  programs.fastfetch = {
  enable = true;
  settings = {
    logo = {
      source = "~/Pictures/cerydraG.jpeg";
      type = "kitty";
      width = 24;
      height = 10;
      padding = {
        right = 4;
        top = 1;
      };
    };
    display = {
      separator = " "; # 去掉繁琐的分隔符
      color = "magenta"; # 整体基调：紫色（NixOS 官方色）
    };
    modules = [
      "title"
      {
        type = "separator";
        string = "─"; # 简单的横线
      }
      {
        type = "os";
        key = " "; # 使用 Nerd Font 的 NixOS 图标
        keyColor = "blue";
      }
      {
        type = "kernel";
        key = " ";
        keyColor = "blue";
      }
      {
        type = "packages";
        key = "󰏖 ";
        keyColor = "blue";
      }
      {
        type = "shell";
        key = " ";
        keyColor = "yellow";
      }
      {
        type = "wm";
        key = " ";
        keyColor = "yellow";
      }
      {
        type = "uptime";
        key = "󰅐 ";
        keyColor = "green";
      }
      {
        type = "memory";
        key = "󰑭 ";
        keyColor = "green";
      }
      "break"
      {
        type = "colors";
        symbol = "circle"; # 底部显示色块，增加美感
      }
    ];
  };
};

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
  home.packages = with pkgs; [
    ffmpegthumbnailer
    p7zip
    poppler
    imagemagick
    ripgrep
    fzf
    fd
    jq
  ];
  xdg.configFile."starship.toml".source = ./starship.toml;
}
