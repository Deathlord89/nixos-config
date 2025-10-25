{
  description = "Your new nix config";

  inputs = {
    # Nix ecosystem
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    systems.url = "github:nix-systems/default-linux";

    # Bleeding edge packages from chaotic nyx, especially CachyOS kernel
    # Don't add follows nixpkgs, else will cause local rebuilds
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declarative disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets management
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secureboot
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Theming
    stylix.url = "github:danth/stylix";

    # Minecraft server
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;
    stateVersion = "24.05";
    username = "ma-gerbig";

    lib = nixpkgs.lib // home-manager.lib;
    myLib = import ./lib {inherit lib;};

    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});

    mkHost = {
      hostname,
      desktop ? null,
      pkgsInput ? inputs.nixpkgs,
    }:
      pkgsInput.lib.nixosSystem {
        specialArgs = {
          inherit
            self
            inputs
            outputs
            myLib
            stateVersion
            username
            hostname
            desktop
            ;
        };
        modules = [
          inputs.disko.nixosModules.disko
          inputs.sops-nix.nixosModules.sops
          inputs.chaotic.nixosModules.default
          #inputs.lanzaboote.nixosModules.lanzaboote
          ./hosts/${hostname}
        ];
      };

    mkHome = modules: pkgs:
      lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = {inherit inputs outputs myLib;};
      };

    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in {
    inherit lib;
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    overlays = import ./overlays {inherit inputs outputs;};
    #hydraJobs = import ./hydra.nix {inherit inputs outputs;};

    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    # NixOS configuration entrypoint
    nixosConfigurations = {
      IG-7B = mkHost {
        hostname = "IG-7B";
        pkgsInput = nixpkgs-stable;
      };
      NAZGUL = mkHost {
        hostname = "NAZGUL";
        pkgsInput = nixpkgs-stable;
      };
      NitroX = mkHost {
        hostname = "NitroX";
      };
      nixos-vm = mkHost {
        hostname = "nixos-vm";
      };
      T460p = mkHost {
        hostname = "T460p";
      };
    };

    # Standalone home-manager configuration entrypoint
    homeConfigurations = {
      "ma-gerbig" = mkHome [./home/ma-gerbig/home.nix ./home/ma-gerbig/nixpkgs.nix] pkgsFor.x86_64-linux;
    };
  };
}
