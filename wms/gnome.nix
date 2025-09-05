{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.gnome = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.gnome.enable {
    services.xserver.enable = true;

    services.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true;

    services.xserver.xkb = {
      layout = "us,ru";
      variant = ",";
      options = "grp:ctrl_space";
    };

  };
}
