# notify for sway
{
  lib,
  config,
  pkgs,
  vars,
  ...
}:
{
  # enable if sway enabled
  config = lib.mkIf (config.sway.enable) {
    home-manager.users.${vars.user} = {
      services = {
        mako = {
          settings = {
            enable = true;
            actions = true;
            defaultTimeout = 3000;
            icons = true;
          };
        };
      };
    };
  };
}
