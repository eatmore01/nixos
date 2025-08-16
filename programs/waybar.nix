{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
let
  modules-left = [
    "sway/workspaces"
    "sway/mode"
  ];

  modules-center = [
    "sway/language"
  ];

  modules-right = [
    "tray"
    "custom/separator#line"
    "network"
    "custom/separator#line"
    "cpu"
    "memory"
    "custom/separator#line"
    "pulseaudio"
    "custom/separator#line"
    "clock"
  ];
in
{

  options.waybar = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf (config.waybar.enable) {
    environment.systemPackages = with pkgs; [
      waybar
    ];

    home-manager.users.${vars.user} = {
      programs.waybar = {
        enable = true;
        package = pkgs.waybar;

        style = ''
          @define-color background #1d2021;
          @define-color foreground #ebdbb2;
          @define-color dim        #928374;
          @define-color yellow     #fabd2f;
          @define-color red        #fb4934;
          @define-color green      #b8bb26;

          * {
          	font-family: "JetBrainsMono Nerd Font";
          	font-weight: bold;
          	min-height: 0;	
          	/* set font-size to 100% if font scaling is set to 1.00 using nwg-look */
          	font-size: 97%;
          	font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';

          }

          window#waybar {
            background: @background;
            color: @foreground;
            transition-property: background-color;
            transition-duration: 0.5s;
          }

          #taskbar button,
          #workspaces button {
            color: @foreground;
          }

          #taskbar button.active,
          #workspaces button.active {
            border-bottom: 1px solid green;
          }

          #taskbar button.urgent,
          #workspaces button.urgent {
            border-bottom: 2px solid red;
          }

          #submap {
            border-bottom: 1px solid red;
          }

          #backlight,
          #backlight-slider,
          #battery,
          #bluetooth,
          #clock,
          #cpu,
          #disk,
          #idle_inhibitor,
          #keyboard-state,
          #memory,
          #mode,
          #mpris,
          #network,
          #power-profiles-daemon,
          #pulseaudio,
          #pulseaudio-slider,
          #taskbar button,
          #taskbar,
          #temperature,
          #tray,
          #window,
          #wireplumber,
          #workspaces,
          #custom-backlight,
          #custom-browser,
          #custom-cava_mviz,
          #custom-cycle_wall,
          #custom-dot_update,
          #custom-file_manager,
          #custom-keybinds,
          #custom-keyboard,
          #custom-light_dark,
          #custom-lock,
          #custom-hint,
          #custom-hypridle,
          #custom-menu,
          #custom-playerctl,
          #custom-power_vertical,
          #custom-power,
          #custom-quit,
          #custom-reboot,
          #custom-settings,
          #custom-spotify,
          #custom-swaync,
          #custom-tty,
          #custom-updater,
          #custom-weather,
          #custom-weather.clearNight,
          #custom-weather.cloudyFoggyDay,
          #custom-weather.cloudyFoggyNight,
          #custom-weather.default, 
          #custom-weather.rainyDay,
          #custom-weather.rainyNight,
          #custom-weather.severe,
          #custom-weather.showyIcyDay,
          #custom-weather.snowyIcyNight,
          #custom-weather.sunnyDay {
            padding: 6px;
            color: @foreground;
          }

          #battery.warning,
          #disk.warning,
          #memory.warning,
          #cpu.warning {
            border-top: 3px solid @background;
            border-bottom: 3px solid yellow;
          }

          @keyframes blink {
            to {
              color: @background;
            }
          }

          #battery.critical:not(.charging) {
            background-color: @red;
            color: white;
            animation-name: blink;
            animation-duration: 3.0s;
            animation-timing-function: steps(12);
            animation-iteration-count: infinite;
            animation-direction: alternate;
            box-shadow: inset 0 -3px transparent;
          }

          /*-----Indicators----*/
          #custom-hypridle.notactive,
          #idle_inhibitor.activated {
          	color: #39FF14;
          }

          #battery.critical,
          #disk.critical,
          #memory.critical,
          #cpu.critical {
            border-top: 3px solid @background;
            border-bottom: 3px solid red;
          }

          #temperature.critical {
          	background-color: red;
          }

          #battery.charging {
            border-top: 3px solid @background;
            border-bottom: 3px solid green;
          }

          #backlight-slider slider,
          #pulseaudio-slider slider {
          	min-width: 0px;
          	min-height: 0px;
          	opacity: 0;
          	background-image: none;
          	border: none;
          	box-shadow: none;
          }

          #backlight-slider trough,
          #pulseaudio-slider trough {
          	min-width: 80px;  
          	min-height: 5px; 
          	border-radius: 5px;
          	background-color: @dim;
          }

          #backlight-slider highlight,
          #pulseaudio-slider highlight {
          	min-height: 10px; 
          	border-radius: 5px;
          	background-color: @green;
          }
        '';
        settings = {
          Main = {
            layer = "bottom";
            position = "bottom";
            height = 26;

            tray = {
              spacing = 5;
            };

            modules-left = modules-left;
            modules-center = modules-center;
            modules-right = modules-right;

            "sway/workspaces" = {
              format = "{icon}";
              format-icons = {
                "1" = "1";
                "2" = "2";
                "3" = "3";
                "4" = "4";
                "5" = "5";
                "6" = "6";
                "7" = "7";
                "8" = "8";
              };
              all-outputs = true;
              persistent_workspaces = {
                "1" = [ ];
                "2" = [ ];
                "3" = [ ];
                "4" = [ ];
                "5" = [ ];
                "6" = [ ];
                "7" = [ ];
                "8" = [ ];
              };
            };

            "sway/language" = {
              format = "Lang: {}";
              format-en = "US";
              format-tr = "RU";
              keyboard-name = "at-translated-set-2-keyboard";
              on-click = "swaymsg input type:keyboard xkb_switch_layout next";
            };
            clock = {
              format = "{:%H:%M %d.%m.%Y}";
              # on-click = "sleep 0.1; ${pkgs.eww}/bin/eww open --toggle calendar --screen 0";
            };
            "custom/separator#line" = {
              format = "|";
              interval = 1;
              tooltip = false;
            };
            cpu = {
              format = "cpu: {usage}%";
              interval = 1;
            };
            memory = {
              format = "ram: {}%";
              interval = 1;
            };
            battery = {
              interval = 1;
              states = {
                warning = 30;
                critical = 15;
              };
              format = "battery: {capacity}%";
              format-charging = "battery: {capacity}%";
              max-length = 25;
            };
            network = {
              format-wifi = "{ipaddr}/{cidr}";
              format-ethernet = "{ifname} {ipaddr}/{cidr}";
              format-disconnected = "X";
              tooltip-format = "{ifname}: {ipaddr}/{cidr}";
              tooltip-format-wifi = "{essid} {icon} - power: {signalStrength}%";
              tooltip-format-ethernet = "{ifname}";
              tooltip-format-disconnected = "Disconnected";
              interval = 5;
              # on-click = "nm-connection-editor";
            };
            pulseaudio = {
              format = "Volume - out: {volume}% inp: {format_source}";
              format-muted = "Muted - out: {volume}% inp: {format_source} ";
              tooltip = true;
              tooltip-format = "out: {desc} | {volume}%";
              on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
            };
          };
        };
      };
    };
  };
}
