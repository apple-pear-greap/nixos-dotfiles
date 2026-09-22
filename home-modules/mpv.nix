{ pkgs, config, ... }:
{
  programs.mpv = {
    enable = true;

    package = pkgs.mpv.override { youtubeSupport = false; };
    config = {
      # hardware encoding
      hwdec = "auto";
      # GPU render
      vo = "gpu-next";
      # high quality render
      profile = "gpu-hq";
      # Youtube
      ytdl-format = "bestvideo+bestaudio/best";
      ytdl-raw-options = [
        "cookies-from-browser=firefox" # 或指定文件：cookies=/path/to/cookies.txt
      ];

      cache = "yes";
    };
  };
  home.packages = with pkgs; [
    yt-dlp
  ];
}
