{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
{
  home-manager.users.${vars.user} = {
    home = {
      packages = with pkgs; [
        tofi
      ];
    };

    home.file = {
      ".config/ghostty/config" = {
        text = ''
          font-family = "JetBrains Mono"
          font-size = 14

          background = 000000
          # transparance
          background-opacity = 0.99
          background-blur = 5

          foreground = ffffff

          window-padding-x = 5
          window-padding-y = 5
          window-padding-balance = true

          cursor-style = "bar"

          bold-is-bright = true

          theme = Darkside
        '';
      };
    };
  };
}
