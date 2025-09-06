{
  config,
  pkgs,
  lib,
  vars,
  home-manager,
  ...
}:
{
  # enable needed wms for etm
  sway.enable = if vars.wms.sway.enable && vars.wms.gnome.enable == false then true else false;
  gnome.enable = if vars.wms.gnome.enable && vars.wms.sway.enable == false then true else false;

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

  environment.systemPackages = with pkgs; [
    obsidian
    telegram-desktop
    discord
    ghostty # terminal
    vscode # manage by home-manager
    obs-studio
    fastfetch
    go
    firefox
    atac # tui postman
    yazi # file manager for test
    vlc # media player
    neovim
    # devops utils
    kubectl
    kubectx
    kubernetes-helm
    terraform
    k9s
    terragrunt
    terraform-docs
    helm-docs
    kind
    talosctl
  ];

  # enable amnezia vpn service
  programs.amnezia-vpn.enable = true;
}
