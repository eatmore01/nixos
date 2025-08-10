{ config, pkgs, lib, vars, home-manager, ... }:
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

  # enable sway wm for etm
  sway.enable = true;

  # define system etm user
  # system define shell as a default shell and next configure it with home-manager for etm
  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
    users.${vars.user} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "storage" "plugdev"];
    };
  };

  environment.systemPackages = with pkgs; [
    obsidian
    telegram-desktop
    vscode
    discord
    kubectl
    kubernetes-helm
    terraform
    k9s
    terragrunt
    terraform-docs
    helm-docs
    fastfetch
  ];
  
  
  # enable amnezia vpn service
  programs.amnezia-vpn.enable = true;
}
