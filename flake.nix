{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declarative disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets managemant
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secureboot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    systems,
    nixos-hardware,
    disko,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
    baseModules = [
      ./modules/sops.nix
    ];
  in {
    inherit lib;
    # Custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs outputs;};

    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});

    # Standalone home-manager configuration entrypoint
    homeConfigurations = {
      ma-gerbig = lib.homeManagerConfiguration {
        modules = [./home/ma-gerbig];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };

    # NixOS configuration entrypoint
    nixosConfigurations = {
      T460p = lib.nixosSystem {
        modules =
          baseModules
          ++ [
            ./hosts/T460p
            disko.nixosModules.disko

            nixos-hardware.nixosModules.lenovo-thinkpad-t460p
          ];
        specialArgs = {
          inherit inputs outputs;
        };
      };

      nixos-test = lib.nixosSystem {
        modules = baseModules ++ [./hosts/nixos-test];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}
