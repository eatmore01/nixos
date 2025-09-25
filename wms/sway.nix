{
  config,
  lib,
  pkgs,
  vars,
  host,
  ...
}:
let
  bar =
    if vars.wms.sway.statusBar == "waybar" then
      {
        command = "waybar";
      }
    else if vars.wms.sway.statusBar == "i3status" then
      {
        position = "bottom";
        statusCommand = "i3status-rs ~/.config/i3status-rust/config-etm.toml";
      }
    else
      { };

  defaultOoutput =
    if vars.gpu.nvidia.enable then
      {
        "*".scale = "1";
        "DP-1" = {
          mode = "2560x1440@120Hz";
        };
      }
    else if vars.gpu.intel.enable then
      {
        "*".scale = "1";
        "eDP-1" = {
          mode = "1920x1080@60Hz";
        };
        "HDMI-A-1" = {
          mode = "2560x1440@60Hz";
        };
      }
    else
      { };

  mainMonitor =
    if vars.gpu.nvidia.enable then
      "DP-1"
    else if vars.gpu.intel.enable then
      "HDMI-A-1"
    else
      "";

  secondMonitor =
    if vars.gpu.nvidia.enable && vars.twoScreen == true then
      "HDMI-A-1"
    else if vars.gpu.intel.enable && vars.twoScreen == true then
      "eDP-1"
    else
      "";

in
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
          xwayland
          swaylock
          swayidle
          wl-clipboard
          wlr-randr
          wf-recorder
          mako
          grim
          slurp
        ];
      };
    };

    # choose status bar for sway
    waybar.enable =
      if
        vars.wms.sway.enable && vars.wms.gnome.enable == false && vars.wms.sway.statusBar == "waybar"
      then
        true
      else
        false;
    i3status.enable =
      if
        vars.wms.sway.enable && vars.wms.gnome.enable == false && vars.wms.sway.statusBar == "i3status"
      then
        true
      else
        false;

    # choose login manager
    greetd.enable =
      if
        vars.wms.sway.enable && vars.wms.gnome.enable == false && vars.wms.sway.loginManager == "greetd"
      then
        true
      else
        false;

    # app launcher
    tofi.enable = true;

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

          bars = [
            bar
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

          output = defaultOoutput;

          workspaceOutputAssign =
            if vars.wms.sway.twoScreen == true then
              [
                {
                  output = mainMonitor;
                  workspace = "1";
                }
                {
                  output = mainMonitor;
                  workspace = "2";
                }
                {
                  output = mainMonitor;
                  workspace = "3";
                }
                {
                  output = mainMonitor;
                  workspace = "4";
                }
                {
                  output = secondMonitor;
                  workspace = "5";
                }
              ]
            else
              [
                {
                  output = mainMonitor;
                  workspace = "1";
                }
                {
                  output = mainMonitor;
                  workspace = "2";
                }
                {
                  output = mainMonitor;
                  workspace = "3";
                }
                {
                  output = mainMonitor;
                  workspace = "4";
                }
                {
                  output = mainMonitor;
                  workspace = "5";
                }
              ];

          defaultWorkspace = "workspace number 1";

          bindkeysToCode = true;
          keybindings = {
            "${modifier}+Return" = "exec ${terminal}";
            "${modifier}+d" = "exec ${menu}";
            "${modifier}+q" = "kill";
            "${modifier}+f" = "fullscreen";
            # qwe
            "${modifier}+h" = "focus left";
            "${modifier}+j" = "focus down";
            "${modifier}+k" = "focus up";
            "${modifier}+l" = "focus right";
            # arrrows
            "${modifier}+Left" = "focus left";
            "${modifier}+Down" = "focus down";
            "${modifier}+Up" = "focus up";
            "${modifier}+Right" = "focus right";
            #  qwe
            "${modifier}+Shift+h" = "move left";
            "${modifier}+Shift+j" = "move down";
            "${modifier}+Shift+k" = "move up";
            "${modifier}+Shift+l" = "move right";
            "${modifier}+Shift+space" = "floating toggle";
            "${modifier}+space" = "focus mode_toggle";
            "${modifier}+Shift+c" = "reload";
            "${modifier}+Shift+e" = "swaymsg exit";
            "${modifier}+s" = "layout stacking";
            "${modifier}+w" = "layout tabbed";
            "${modifier}+e" = "layout toggle split";
            "${modifier}+Shift+f" =
              "exec grim /tmp/swayshot.png && wl-copy < /tmp/swayshot.png && mv /tmp/swayshot.png ~/pic/screen-$(date +%s).png";
            "${modifier}+Shift+s" =
              "exec grim -g \"$(slurp)\" /tmp/swayshot.png && wl-copy < /tmp/swayshot.png && mv /tmp/swayshot.png ~/pic/space-$(date +%s).png";

            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";

            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";

            # move windows via arrwos in the same workspace
            "${modifier}+Shift+Left" = "move left";
            "${modifier}+Shift+Down" = "move down";
            "${modifier}+Shift+Up" = "move up";
            "${modifier}+Shift+Right" = "move right";

            "${modifier}+r" = "mode resize";

            "${modifier}+Escape" = "exec swaymsg exit";
          };
        };
      };
    };
  };
}
