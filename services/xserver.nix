{ lib, config, ... }:
{
  config = lib.mkIf (config.sway.enable) {
    # disable x servcer, use only wayland
    # if xserver disabled and used wayladn compositor, sesion will be work on wayland not X
    services.xserver.enable = false;
  };
}
