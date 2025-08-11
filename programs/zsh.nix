{ vars, git, host, home-manager, ... }:
{
  home-manager.users.${vars.user} = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initContent = ''
        export KUBECONFIGS="?"
        export EDITOR=vim
      '';

      shellAliases = {
        # helpers
        nixrebuild = "sudo nixos-rebuild switch";
        nix-clear = "sudo nix-collect-garbage -d";
        etm-rebuild = "sudo nixos-rebuild switch --flake ~/.nixos#etm";
        etm-flake-upd = "sudo nix flake update --flake ~/.nixos";

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
        plugins = [ "git" "history" ];
      };
    };
  };
}