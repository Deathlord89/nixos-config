{
  inputs,
  config,
  lib,
  ...
}: let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      trusted-users = [
        "root"
        "ma-gerbig"
      ];
      auto-optimise-store = lib.mkDefault true;

      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Add each flake input as a registry and nix_path
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    # Perform garbage collection weekly to maintain low disk usage
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  programs.nh = {
    enable = true;
    #clean.enable = true;
    #clean.extraArgs = "--keep-since 4d --keep 3";
    #flake = "/home/ma-gerbig/git/nixos-config"; # TODO: Set in home config
  };
}
