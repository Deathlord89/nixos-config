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
    ../common/hardware/nvidia

    ../common/optional/podman.nix

    # Include host specific services
    ./services

    # Include the results of the hardware scan.
    ./disko.nix
    ./hardware-configuration.nix
  ];

  # Define your hostname
  networking = {
    hostName = "NAZGUL";
    hostId = "205ed76c";
  };

  # Bootloader add zfs support
  boot = {
    supportedFilesystems = ["zfs"];
    zfs.extraPools = ["zstorage"];
  };

  services = {
    zfs = {
      trim.enable = true;
      autoScrub.enable = true;
    };
    nfs.server.enable = true;
  };

  #Open Ports for zfs shares
  networking.firewall.allowedTCPPorts = [2049];

  hardware.nvidia = {
    nvidiaSettings = lib.mkForce false;
  };

  # Preserve space by sacrificing documentation
  documentation = {
    nixos.enable = false;
  };

  system = {
    inherit stateVersion;
  };
}
