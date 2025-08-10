
{ lib, pkgs, config, ... }:
{
  # intel drivers for gpu options
  options.drivers.intel = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = mkIf (config.drivers.intel.enable) {
    #  enableHybridCodec enable support hybrid codecs, and it will boost perfomance and add support new codec formats.
    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };

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