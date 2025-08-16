{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
let
  settingsFormat = pkgs.formats.toml { };
in
{
  options.i3status = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf (config.i3status.enable) {
    environment.systemPackages = with pkgs; [
      i3status-rust
    ];

    home-manager.users.${vars.user} = {
      programs.i3status-rust.enable = true;

      # generate config file
      # xdg = ~/.config
      # in this case will be placed at ~/.config/i3status-rust/config-etm.toml
      xdg.configFile."i3status-rust/config-etm.toml".source = settingsFormat.generate "config-etm.toml" {
        block = [
          {
            block = "net";
            device = "enp4s0"; # default netowkr interface
            interval = 1;
            format = " $icon: $ip ($speed_down) ";
            inactive_format = "$icon: down";
          }
          {
            block = "memory";
            format = " $icon $mem_used_percents ";
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "temperature";
            format = " $icon $max max ";
            format_alt = " $icon $min min, $max max, $average avg ";
            interval = 10;
            chip = "*-isa-*";
          }
          {
            block = "sound";
            click = [
              {
                button = "left";
                cmd = "pavucontrol";
              }
            ];
          }
          {
            block = "keyboard_layout";
            driver = "sway";
          }
          {
            block = "time";
            interval = 60;
            format = " $timestamp.datetime(f:'%Y-%m-%d %H:%M:%S') ";
          }
        ];
      };
    };
  };
}
