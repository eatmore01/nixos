{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
{
  options.foot = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf (config.foot.enable) {
    home-manager.users.${vars.user} = {
      programs.foot = {
        enable = true;

        settings = {
          main = {
            font = "monospace:size=13";
          };

          cursor = {
            style = "beam";
            blink = "yes";
          };

          colors = {
            background = "000000";
          };
        };
      };
    };
  };
}
