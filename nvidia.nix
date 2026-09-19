{ pkgs, config, lib, ...}:
let
  myCachyKernel = pkgs.linuxPackages_cachyos.cachyOverride {
    cachyVars = pkgs.linuxPackages_cachyos.kernel.cachyConfig.cachyVars // {
      "_processor_opt" = "GENERIC_V3";
    };
  };
in
{

  services.udev.extraRules = ''
    # Intel 核显
    KERNEL=="card*", KERNELS=="0000:00:02.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/intel-igpu"
    # NVIDIA 独显
    KERNEL=="card*", KERNELS=="0000:01:00.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/nvidia-dgpu"
  '';

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs; [
      intel-media-driver
    ];
  };

  services.scx.enable = true;
  boot.kernelPackages = myCachyKernel;
  services.xserver.videoDrivers = ["modesetting" "nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    # package = config.boot.kernelPackages.nvidiaPackages.stable;
    package = pkgs.nvidia_cachyos;

    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };

  hardware.nvidia.prime = {
    offload.enable = false;
    sync.enable = true;
    
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
}
