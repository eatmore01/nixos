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

    i3status.enable = true;

    environment.pathsToLink = [ "/libexec" ];

    # i3 settings
    services = {
      displayManager = {
        defaultSession = "none+i3";
      };

      xserver = {
        enable = true;

        xkb = {
          layout = "us,ru";
          variant = "";
          options = "grp:ctrl_space_toggle";
        };

        desktopManager = {
          xterm.enable = false;
        };

        windowManager.i3 = {
          enable = true;
          package = pkgs.i3;
          configFile = ./i3-config;
          extraPackages = with pkgs; [
            i3lock
          ];
        };
      };
    };

    services.compton.enable = true;

    environment.systemPackages = with pkgs; [
      xorg.xrandr
      dmenu
      dunst
      libnotify
      lxappearance
      mako
      maim
      xclip
      i3
    ];
  };
}
