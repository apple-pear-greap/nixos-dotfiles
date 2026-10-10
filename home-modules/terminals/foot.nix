{ config, ... }:
{
  xdg.configFile.foot = config.my.xdg.creatSymlink "foot";
}
