{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
{
  options.alacritty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf (config.alacritty.enable) {
    home-manager.users.${vars.user} = {
      programs.alacritty = {
        enable = true;
      };

      home.file = {
        ".config/alacritty/alacritty.toml" = {
          text = ''
            [colors.primary]
            background = "0x1e1e2e"
            foreground = "0xcdd6f4"

            [cursor]
            style = "Beam"

            [font]
            size = 12.5

            [scrolling]
            history = 10000
            multiplier = 3

            [window]
            decorations = "full"
            dynamic_padding = true
            opacity = 0.95

            decorations_theme_variant = "Dark"

            [window.padding]
            x = 10
            y = 10
          '';
        };
      };
    };
  };
}
