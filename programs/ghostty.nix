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
          font-size = 15

          cursor-style = "bar"

          bold-is-bright = true

          theme = Darkside
        '';
      };
    };
  };
}
