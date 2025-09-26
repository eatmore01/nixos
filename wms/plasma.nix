{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
{
  options.plasma = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.plasma.enable {
    ghostty.enable = true;

    services.xserver.enable = true;

    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    services.xserver.xkb = {
      layout = "us,ru";
      variant = ",";
    };
  };
}
