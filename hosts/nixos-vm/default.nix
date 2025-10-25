{
  lib,
  config,
  pkgs,
  inputs,
  stateVersion,
  ...
}: {
  imports = [
    ../common/users/ma-gerbig

    ../common/base

    ../common/optional/podman.nix
    ../common/optional/database.nix

    # Include host specific services
    ./services

    # Include the results of the hardware scan.
    ./disko.nix
    ./hardware-configuration.nix
  ];

  # Define your hostname
  networking = {
    hostName = "nixos-vm";
    hostId = "f57f18c8";
  };

  # Bootloader add zfs support
  boot = {
    plymouth.enable = lib.mkForce false;
    supportedFilesystems = ["zfs"];
  };

  system = {
    inherit stateVersion;
  };
}
