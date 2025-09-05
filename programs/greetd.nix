{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
{
  options.greetd = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf (config.greetd.enable) {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          # greetd.tuigreet -> tuigreet in unstable packages
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
          user = vars.user;
        };
      };
    };
  };
}
