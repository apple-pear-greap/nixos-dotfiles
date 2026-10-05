{ config, lib, ... }:
let
  configPath = "${config.home.homeDirectory}/nixos-config/config";
  creatSymlink = subpath: {
    source = config.lib.file.mkOutOfStoreSymlink "${configPath}/${subpath}";
    recursive = true;
  };
in
{
  options.my.xdg = {
    creatSymlink = lib.mkOption {
      type = lib.types.functionTo lib.types.attrs;
      readOnly = true;
      internal = true;
      description = "creat a symblink to config/<subpath> for xdg.configFile";
    };
    creatSymlinks = lib.mkOption {
      type = lib.types.functionTo lib.types.attrs;
      readOnly = true;
      internal = true;
      description = "accpet a lists,creat symblinks to config/<subpath> for xdg.configFile";
    };
  };
  config.my.xdg = {
    inherit creatSymlink;
    creatSymlinks = 
      subpaths: lib.genAttrs subpaths creatSymlink;
  };
}
