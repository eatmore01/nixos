{ config, lib, ... }:
# with lib; = lib.mkOptions
{
  # wayland
  options.wlwm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
}
