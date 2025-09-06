{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
{
  options.gnome = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.gnome.enable {
    services.xserver.enable = true;

    services.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true;

    services.xserver.xkb = {
      layout = "us,ru";
      variant = ",";
    };

    home-manager.users.${vars.user} = {
      dconf = {
        enable = true;
        settings = {
          "org/gnome/shell/extensions/user-theme" = {
            name = "catppuccin-mocha-mauve-standard+rimless";
          };

          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            icon-theme = "kanagawa-icon-theme";
            enable-hot-corners = false;
          };

          "org/gnome/desktop/input-sources" = {
            sources = "[('xkb', 'us'), ('xkb', 'ru')]";
            current = 0; # 0 - us | primary layoout
          };
          "org/gnome/settings-daemon/plugins/keyboard" = {
            active = true;
          };
          "org/gnome/desktop/wm/keybindings" = {
            switch-input-source = [ "<Primary>space" ]; # ctrl + space change layoutqw
            switch-input-source-backward = [ ];
          };
        };
      };

      gtk = {
        enable = true;
        theme = {
          name = "catppuccin-mocha-mauve-standard+rimless";
          package = pkgs.catppuccin-gtk.override {
            accents = [ "mauve" ];
            size = "standard";
            tweaks = [ "rimless" ];
            variant = "mocha";
          };
        };
        cursorTheme = {
          package = pkgs.catppuccin-cursors.mochaDark;
          name = "catppuccin-mocha-dark-cursors";
        };

        iconTheme = {
          name = "kanagawa-icon-theme";
          package = pkgs.kanagawa-icon-theme;
        };
      };
    };
  };
}
