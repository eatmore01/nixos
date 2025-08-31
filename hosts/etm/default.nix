{
  config,
  pkgs,
  lib,
  vars,
  home-manager,
  ...
}:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # greetd.tuigreet -> tuigreet in unstable packages
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "etm";
      };
    };
  };

  # enable needed wms for etm
  sway.enable = if vars.wms.sway.enable then true else false;
  xfce.enable = if vars.wms.xfce.enable then true else false;

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
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    obsidian
    telegram-desktop
    discord
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
