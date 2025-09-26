{
  config,
  lib,
  pkgs,
  vars,
  host,
  ...
}:
let
  configPath = if vars.wms.i3.terminal == "alacritty" then ./i3-conf-alacritty else ./i3-conf-ghostty;
in
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

    dmenu.enable = true;

    alacritty.enable = if vars.wms.i3.terminal == "alacritty" then true else false;
    ghostty.enable = if vars.wms.i3.terminal == "ghostty" then true else false;

    environment.pathsToLink = [ "/libexec" ];

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
          configFile = configPath;
          extraPackages = with pkgs; [
            i3lock
          ];
        };
      };
    };

    services.compton.enable = true;

    environment.systemPackages = with pkgs; [
      xorg.xrandr
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
