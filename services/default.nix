{ config, pkgs, lib, home-manager, ... }:
{
  imports =
    [
      ./sound.nix
      ./dbus.nix
      ./gvfs.nix
      ./xdg-portal.nix
      ./xserver.nix
    ];
}