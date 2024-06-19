{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
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

  outputs = inputs @ { self, nixpkgs, nixos-hardware, disko, home-manager, ... }: {
    nixosConfigurations = {
      T460p = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/T460p

          # add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t460p

          disko.nixosModules.disko

          home-manager.nixosModules.home-manager {
            home-manager.users.ma-gerbig = import ./home/ma-gerbig;
	        }
        ];
      };

      nixos-test = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
	      modules = [
          ./hosts/nixos-test

          home-manager.nixosModules.home-manager {
            home-manager.users.ma-gerbig = import ./home/ma-gerbig;
          }
        ];
      };
    };
  };
}
