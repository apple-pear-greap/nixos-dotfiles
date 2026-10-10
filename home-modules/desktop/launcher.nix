{ config, ... }:
{
  xdg.configFile.rofi = config.my.xdg.creatSymlink "rofi";
}
