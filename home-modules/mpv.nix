{ pkgs, config, ... }:
{
  programs.mpv = {
    enable = true;

    config = {
      # hardware encoding
      hwdec = "auto";
      # GPU render
      vo = "gpu-next";
      # high quality render
      profile = "gpu-hq";
      # Youtube
      ytdl-format = "bestvideo+bestaudio/best";

      cache = "yes";
      cache-default = 400000;
    };
    home.packages = with pkgs; [
      yt-dlp
    ];
  };
}
