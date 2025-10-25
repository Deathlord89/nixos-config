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
    nixpkgs-stable,
    nixpkgs,
    self,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;
    stateVersion = "24.05";
    username = "ma-gerbig";

    myLib = import ./lib {inherit nixpkgs;};

    forAllSystems = f: nixpkgs.lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = nixpkgs.lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );

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
          inputs.sops-nix.nixosModules.sops
          inputs.chaotic.nixosModules.default
          #inputs.lanzaboote.nixosModules.lanzaboote
          #./hosts/${hostname}
          ./hosts
        ];
      };
  in {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

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
    # No longer functional due to flake restructuring
    #homeConfigurations = {
    #  "ma-gerbig" = mkHome [./home/ma-gerbig/home.nix ./home/ma-gerbig/nixpkgs.nix] pkgsFor.x86_64-linux;
    #};

    # Custom packages; acessible via 'nix build', 'nix shell', etc
    # packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    packages = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./pkgs {inherit pkgs;}
    );

    # Custom overlays
    overlays = import ./overlays {inherit inputs;};

    # Devshell for bootstrapping
    # Accessible via 'nix develop' or 'nix-shell' (legacy)
    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./shell.nix {inherit pkgs;}
    );

    formatter = forAllSystems (system: self.packages.${system}.alejandra);
  };
}
