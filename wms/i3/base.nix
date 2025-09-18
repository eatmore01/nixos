{
  config,
  lib,
  pkgs,
  vars,
  host,
  ...
}:
{
  options.i3 = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable i3 window manager";
    };
  };

  config = lib.mkIf (config.i3.enable) {

    i3status.enable = if vars.wms.i3.enable then true else false;

    greetd.enable = if vars.wms.i3.enable && vars.wms.i3.loginManager == "greetd" then true else false;

    tofi.enable = true;

    environment.pathsToLink = [ "/libexec" ];
    # i3 settings
    services.xserver = {
      enable = true;

      desktopManager = {
        xterm.enable = false;
      };

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3;
        configFile = ./i3-config;
      };
    };

    services.compton.enable = true;

    environment.systemPackages = with pkgs; [
      xorg.xrandr
      tofi
      dunst
      libnotify
      lxappearance
      wl-clipboard
      mako
      grim
      slurp
    ];
  };
}
