{
  config,
  pkgs,
  nur,
  lib,
  vars,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    steam
  ];

  programs = {
    steam = {
      enable = true;
    };
    gamemode.enable = true;
    # Better Gaming Performance
    # Steam: Right-click game - Properties - Launch options: `gamemoderun %command%`
  };
}
