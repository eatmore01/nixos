{ config, pkgs, lib, home-manager, ... }:
{
  # for sway screen sharing in discord and browser
  config = lib.mkIf (config.sway.enable) {
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
      ];
    };
  };
}
