{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
{
  config = lib.mkIf (config.i3.enable) {
    home-manager.users.${vars.user} = {
      home.file = {
        ".config/scripts/screenshot" = {
          text = ''
            #!/bin/sh

            FILE="/home/$USER/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"

            case "$1" in
              full)
                maim "$FILE" && xclip -selection clipboard -t image/png -i "$FILE"
                ;;
              select)
                maim --select "$FILE" && xclip -selection clipboard -t image/png -i "$FILE"
                ;;
              *)
                echo "Usage: $0 {full|select}"
                exit 1
                ;;
            esac
          '';
          executable = true;
        };
      };
    };
  };
}
