{
  inputs,
  pkgs,
  home-manager,
  vars,
  lib,
  pkgsStable,
  ...
}:
let
  system = vars.system;
in
{
  # main etm profile
  etm = lib.nixosSystem {
    inherit system pkgs;
    # define let vars global
    specialArgs = {
      inherit
        inputs
        pkgs
        home-manager
        pkgsStable
        vars
        ;
      host = "etm";
      git = {
        username = "eatmore01";
        email = "etm@qq.com";
      };
    };

    # backupFileExtension - home-manager existing dotfiles will be backups and not throw with error
    modules = [
      ./configuration.nix

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
        };
      }
    ];
  };
}
