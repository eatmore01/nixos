{
  config,
  pkgs,
  lib,
  vars,
  home-manager,
  pkgsStable,
  ...
}:
{
  # enable needed wms for etm
  sway.enable =
    if vars.wms.sway.enable && vars.wms.plasma.enable == false && vars.wms.i3.enable == false then
      true
    else
      false;
  plasma.enable =
    if vars.wms.plasma.enable && vars.wms.sway.enable == false && vars.wms.i3.enable == false then
      true
    else
      false;
  i3.enable =
    if vars.wms.i3.enable && vars.wms.sway.enable == false && vars.wms.plasma.enable == false then
      true
    else
      false;

  libvirt.enable = if vars.libvirt.enable then true else false;

  # define system etm user
  # system define shell as a default shell and next configure it with home-manager for etm
  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
    users.${vars.user} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "storage"
        "plugdev"
        "libvirtd"
        "qemu-libvirtd"
      ];
    };
  };

  environment.systemPackages =
    with pkgs;
    [
      telegram-desktop
      discord
      vscode # manage by home-manager
      obs-studio
      fastfetch
      go
      firefox
      brave
      atac # tui postman
      yazi # file manager for test
      vlc # media player
      neovim
      google-chrome
      # devops utils
      python314
      yq
      kubectl
      kubectx
      kubeswitches # https://github.com/eatmore01/kubeswitches
      kubernetes-helm
      terraform
      k9s
      terragrunt
      helm-docs
      kind
      talosctl
    ]
    ++ [ pkgsStable.terraform-docs ];

  # enable amnezia vpn service
  programs.amnezia-vpn.enable = true;
  programs.openvpn3.enable = true;
}
