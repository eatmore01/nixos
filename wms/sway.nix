{
  config,
  lib,
  pkgs,
  vars,
  host,
  ...
}:
{
  # custom option for enable sway
  options.sway = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable sway window manager";
    };
  };

  config = lib.mkIf (config.sway.enable) {
    programs = {
      sway = {
        enable = true;
        extraPackages = with pkgs; [
          wl-clipboard
          wlr-randr
          xwayland
          swaylock
          swayidle
          wf-recorder
          mako
          grim
          slurp
        ];
      };
    };

    # x server disabled when sway.enable = true
    # if xserver disabled and used wayladn compositor, sesion will be work on wayland not X
    # enable wayland options for waybar
    wlwm.enable = true;

    # keyrings sway support
    services.gnome.gnome-keyring.enable = true;

    home-manager.users.${vars.user} = {
      home.stateVersion = vars.stateVersion;

      wayland.windowManager.sway = {
        enable = true;
        systemd.enable = true;
        config = rec {
          modifier = "Mod4";
          terminal = "foot";
          menu = "${pkgs.tofi}/bin/tofi-run | xargs swaymsg exec --";

          bars = [ ];

          startup = [
            { command = "waybar"; }
          ];

          input = {
            "type:keyboard" = {
              xkb_layout = "us,ru";
              xkb_variant = ",";
              xkb_options = "grp:ctrl_space_toggle";
            };
            "type:pointer" = {
              accel_profile = "flat";
              pointer_accel = "-0.1"; # beetween -1 - 1
              natural_scroll = "disabled";
            };
          };

          output = {
            "*".scale = "1";
            "DP-1" = {
              mode = "2560x1440@120Hz";
            };
          };

          defaultWorkspace = "workspace number 1";

          keybindings = {
            "--to-code ${modifier}+Return" = "exec ${terminal}";
            "--to-code ${modifier}+d" = "exec ${menu}";
            "--to-code ${modifier}+q" = "kill";
            "${modifier}+f" = "fullscreen";
            # qwe
            "${modifier}+h" = "focus left";
            "${modifier}+j" = "focus down";
            "${modifier}+k" = "focus up";
            "${modifier}+l" = "focus right";
            # arrrows
            "--to-code ${modifier}+Left" = "focus left";
            "--to-code ${modifier}+Down" = "focus down";
            "--to-code ${modifier}+Up" = "focus up";
            "--to-code ${modifier}+Right" = "focus right";
            #  qwe
            "${modifier}+Shift+h" = "move left";
            "${modifier}+Shift+j" = "move down";
            "${modifier}+Shift+k" = "move up";
            "${modifier}+Shift+l" = "move right";
            "${modifier}+Shift+space" = "floating toggle";
            "${modifier}+space" = "focus mode_toggle";
            "--to-code ${modifier}+Shift+c" = "reload";
            "${modifier}+Shift+e" = "swaymsg exit";
            "${modifier}+s" = "layout stacking";
            "${modifier}+w" = "layout tabbed";
            "${modifier}+e" = "layout toggle split";
            "--to-code ${modifier}+Shift+f" =
              "exec grim /tmp/swayshot.png && wl-copy < /tmp/swayshot.png && mv /tmp/swayshot.png ~/pic/screen-$(date +%s).png";
            "--to-code ${modifier}+Shift+s" =
              "exec grim -g \"$(slurp)\" /tmp/swayshot.png && wl-copy < /tmp/swayshot.png && mv /tmp/swayshot.png ~/pic/space-$(date +%s).png";

            "--to-code ${modifier}+1" = "workspace number 1";
            "--to-code ${modifier}+2" = "workspace number 2";
            "--to-code ${modifier}+3" = "workspace number 3";
            "--to-code ${modifier}+4" = "workspace number 4";
            "--to-code ${modifier}+5" = "workspace number 5";

            "--to-code ${modifier}+Shift+1" = "move container to workspace number 1";
            "--to-code ${modifier}+Shift+2" = "move container to workspace number 2";
            "--to-code ${modifier}+Shift+3" = "move container to workspace number 3";
            "--to-code ${modifier}+Shift+4" = "move container to workspace number 4";
            "--to-code ${modifier}+Shift+5" = "move container to workspace number 5";

            # move windows via arrwos in the same workspace
            "--to-code ${modifier}+Shift+Left" = "move left";
            "--to-code ${modifier}+Shift+Down" = "move down";
            "--to-code ${modifier}+Shift+Up" = "move up";
            "--to-code ${modifier}+Shift+Right" = "move right";

            "${modifier}+Escape" = "exec swaymsg exit";
          };
        };
      };
    };
  };
}
