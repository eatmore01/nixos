{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.xfce = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable XFCE desktop environment";
    };
  };

  config = lib.mkIf config.xfce.enable {
    services.xserver = {
      enable = true;
      displayManager = {
        lightdm.enable = true;
        defaultSession = "xfce";
      };
      desktopManager = {
        xfce.enable = true;
      };
    };

    environment.systemPackages = with pkgs.xfce; [
      xfce4-panel
      xfce4-session
      xfce4-settings
      xfwm4
      xfdesktop
      xfce4-appfinder
      xfce4-whiskermenu-plugin
      xfce4-pulseaudio-plugin
      xfce4-power-manager
    ];

    programs.dconf.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
