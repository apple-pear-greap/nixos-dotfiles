{ ... }:

{
  # Daed for network/proxy management
  services.daed = {
    enable = true;
    listen = "0.0.0.0:2023";
    openFirewall = {
      enable = true;
      port = 12345;
    };
  };
}
