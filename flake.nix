{
  inputs = {
    # SUPER FRESH NIXOS / high explore risk
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

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stable,
      nixvim,
      ...
    }@inputs:
    let

      vars = {
        system = "x86_64-linux";
        stateVersion = "25.05"; # 25.11
        user = "etm";
        hostname = "nixos";
        procArch = "intel"; # or amd

        libvirt = {
          enable = false;
        };

        gpu = {
          intel = {
            enable = false;
          };
          nvidia = {
            enable = true;
            openSource = false; # nouveau
          };
        };

        wms = {
          sway = {
            enable = false;
            loginManager = "greetd";
            statusBar = "waybar"; # or i3status | doesnt work with sway.enable = false
            terminal = "foot"; # || alacritty
            twoScreen = false;
          };

          i3 = {
            enable = true;
            terminal = "alacritty"; # ghostty
          };

          plasma = {
            enable = false;
            twoScreen = false;
            # ghostty terminal by default
          };
        };
      };

      pkgs = import nixpkgs {
        system = vars.system;
        config = {
          allowUnfree = true;

        };

        overlays = [
          (self: super: {
            kubeswitches = super.callPackage pkgs/kubeswitches.nix { }; # https://github.com/eatmore01/kubeswitches
          })
        ];

        # for intel gpus
        # enableHybridCodec enable support hybrid codecs, and it will boost perfomance and add support new codec formats.
        packageOverrides = pkgs: {
          vaapiIntel = pkgs.vaapiIntel.override {
            enableHybridCodec = true;
          };
        };
      };

      pkgsStable = import stable {
        system = vars.system;
        config = {
          allowUnfree = true;
        };
      };

      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit
            inputs
            pkgs
            pkgsStable
            home-manager
            vars
            lib
            nixvim
            ;
        }
      );

      homeConfigurations = (
        import ./home-manager {
          inherit
            inputs
            pkgs
            pkgsStable
            home-manager
            vars
            lib
            nixvim
            ;
        }
      );
    };
}
