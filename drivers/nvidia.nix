{
  lib,
  pkgs,
  config,
  vars,
  ...
}:

{
  # nvidia drivers for gpu options
  # only for PC ( nvidia videocard )
  # not for laptop ( intel + discret nvidia )
  options.drivers.nvidia = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable NVIDIA driver configuration for NVIDIA GPUs (PC only, not laptops with hybrid GPUs).";
    };
  };

  config = lib.mkIf config.drivers.nvidia.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
        vdpauinfo
        libva
        libva-utils
      ];
    };

    services.xserver.videoDrivers = [
      (if vars.gpu.nvidia.openSource then "nouveau" else "nvidia")
    ];

    hardware.nvidia = lib.mkIf (!vars.gpu.nvidia.openSource) {
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      dynamicBoost.enable = true;

      nvidiaPersistenced = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      # Currently alpha-quality version has bugs, so false is currently the recommended setting.
      open = false;

      # Enable the Nvidia settings menu (`nvidia-settings`)
      nvidiaSettings = true;

      # can manualy set drivers version
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
}
