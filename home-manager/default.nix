{ config, pkgs, vars, ... }:
{
  home = {
    username = vars.user;
    homeDirectory = "/home/${vars.user}";
    stateVersion = vars.stateVersion;
    packages = [ pkgs.home-manager ];
  };

  programs.home-manager.enable = true;
}
