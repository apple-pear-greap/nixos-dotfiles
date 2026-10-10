{ config, lib, ... }:
{
  options.my.audio.enable = lib.mkEnableOption "PipeWire audio";

  config = lib.mkIf config.my.audio.enable {
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };
  };
}
