{ pkgs, ... }:
let
  audioSwitch = pkgs.writeShellApplication {
    name = "rofi-audio-switch";
    runtimeInputs = with pkgs; [
      bluez
      coreutils
      gnugrep
      jq
      libnotify
      pulseaudio
      rofi
      util-linux
    ];
    text = builtins.readFile ../../scripts/rofi-audio-switch;
  };
in
{
  home.packages = [ audioSwitch ];
  xdg.desktopEntries.audio-switch = {
    name = "音频输出切换";
    comment = "切换音响或连接蓝牙音频设备";
    exec = "rofi-audio-switch";
    icon = "audio-headphones";
    terminal = false;
    categories = [
      "AudioVideo"
      "Audio"
    ];
  };
}
