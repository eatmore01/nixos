{
  inputs = {
    # SUPER FRESH NIXOS / high expore risk
    master = {
      url = "github:NixOS/nixpkgs/master";
    };

    # balance between freshing and stable packa
    unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    # latest full stable release
    stable = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };

    # current pkgs version
    nixpkgs = {
      follows = "unstable"; # or stable
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    vars = {
      system = "x86_64-linux";
      stateVersion = "25.05";
      user = "etm";
      hostname = "nixos";
      gpu = "intel";
    };
    pkgs = import nixpkgs {
      system =  vars.system;
      config = { 
        allowUnfree = true; 
      };
    };
    
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = (
      import ./hosts {
        inherit inputs pkgs home-manager vars lib;
      }
    );

    homeConfigurations = (
      import ./home-manager {
        inherit inputs pkgs home-manager vars lib;
      }
    );
  };
}
