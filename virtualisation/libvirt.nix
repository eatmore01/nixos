{
  pkgs,
  config,
  vars,
  lib,
  ...
}:
{
  options.libvirt = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf (config.libvirt.enable) {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        verbatimConfig = ''
          namespaces = []
          user = ${vars.user}
          group = "users"
        '';
      };
    };
  };
}
