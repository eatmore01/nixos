{
  config,
  pkgs,
  vars,
  nixvim,
  inputs,
  pkgsStable,
  ...
}:
{
  home = {
    username = vars.user;
    homeDirectory = "/home/${vars.user}";
    stateVersion = vars.stateVersion;
    packages = [ pkgs.home-manager ];
  };

  # imports = [
  #   inputs.nixvim.homeModules.nixvim
  # ];

  programs.home-manager.enable = true;
  # programs.nixvim.enable = true;
}
