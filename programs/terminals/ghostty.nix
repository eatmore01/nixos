{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
{
  options.ghostty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf (config.ghostty.enable) {
    environment.systemPackages = with pkgs; [ ghostty ];

    home-manager.users.${vars.user} = {
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
  };
}
