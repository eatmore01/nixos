
{ lib, pkgs, config, ... }:
{
  # intel drivers for gpu options
  options.drivers.intel = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf (config.drivers.intel.enable) {
    hardware.graphics = {
      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
        libva
			  libva-utils
      ];
    };
  };
}