{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
{

  options.dmenu = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf (config.dmenu.enable) {
    environment.systemPackages = with pkgs; [ dmenu ];
  };
}
