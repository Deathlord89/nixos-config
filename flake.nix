{
  description = "Your new nix config";

  inputs = {
    # Nix ecosystem
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    systems.url = "github:nix-systems/default-linux";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
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
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;

    lib = nixpkgs.lib // home-manager.lib;
    myLib = import ./lib {inherit lib;};

    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});

    mkNixos = modules:
      lib.nixosSystem {
        inherit modules;
        specialArgs = {inherit inputs outputs myLib;};
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
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    overlays = import ./overlays {inherit inputs outputs;};
    #hydraJobs = import ./hydra.nix {inherit inputs outputs;};

    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    # NixOS configuration entrypoint
    nixosConfigurations = {
      nixos = mkNixos [./hosts/nixos];
      nixos-test = mkNixos [./hosts/nixos-test];
      T460p = mkNixos [./hosts/T460p];
    };

    # Standalone home-manager configuration entrypoint
    homeConfigurations = {
      "ma-gerbig" = mkHome [./home/ma-gerbig/home.nix ./home/ma-gerbig/nixpkgs.nix] pkgsFor.x86_64-linux;
    };
  };
}
