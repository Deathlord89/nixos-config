{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
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

  outputs = inputs @ { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      T460p = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # Import the previous configuration.nix we used,
          # so the old configuration file still takes effect
          ./configuration.nix

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
