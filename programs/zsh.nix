{
  vars,
  git,
  host,
  home-manager,
  ...
}:
{
  home-manager.users.${vars.user} = {
    home.stateVersion = vars.stateVersion;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initContent = ''
        export KUBECONFIGS="/home/etm/Documents/code/configs/kube-contexts"
        export EDITOR=nvim
        export TERM=xterm-256color

        export LANG=en_US.UTF-8
        export LC_ALL=en_US.UTF-8
      '';

      shellAliases = {
        # helpers
        nixrebuild = "sudo nixos-rebuild switch";
        nix-clear = "sudo nix-collect-garbage -d";
        etm-rebuild = "sudo nixos-rebuild switch --flake ~/.nixos#etm";
        etm-flake-upd = "sudo nix flake update --flake ~/.nixos";

        talos-cluster-create = "talosctl cluster create --workers 2 --name test";
        talos-cluster-destroy = "talosctl cluster destroy --name test";

        l = "ls -la";

        # ?
        start-wvpn = "openvpn3 session-start --config work";
        shutd-wvpn = "openvpn3 session-manage --config work --disconnect";

        # kube
        ktx = "kubectx";
        k = "kubectl";
        h = "helm";
        ks = "kubeswitches";
        # docker
        d = "docker";
        dc = "docker compose";
        # tf
        tf = "terraform";
        tg = "terragrunt";
        # git aliases
        commit = "git add . && git commit -am";
        push = "git push origin";
        pullreb = "git pull origin --rebase";
        # other
        v = "vault";
        gen_tf_doc = "terraform-docs markdown table --output-file README.md --output-mode inject";
        hd = "helm-docs";
      };

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "history"
        ];
      };
    };
  };
}
