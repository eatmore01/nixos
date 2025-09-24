{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
let
  # greetd.tuigreet -> tuigreet in unstable packages
  defaultSessionCmd = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
in
{
  options.greetd = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf (config.greetd.enable) {
    environment.systemPackages = with pkgs; [
      greetd
    ];

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = defaultSessionCmd;
          user = vars.user;
        };
      };
    };
  };
}
