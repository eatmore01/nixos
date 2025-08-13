{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
{
  # setup tofi for wayland compositor
  config = lib.mkIf (config.wlwm.enable) {
    home-manager.users.${vars.user} = {
      home = {
        packages = with pkgs; [
          tofi
        ];
      };

      home.file = {
        ".config/tofi/config" = {
          text = ''
            width = 100%
            height = 100%
            border-width = 0
            outline-width = 0
            padding-left = 35%
            padding-top = 35%
            result-spacing = 25
            num-results = 5
            font = monospace
            background-color = #000A
          '';
        };
      };
    };
  };
}
