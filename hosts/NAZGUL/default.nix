{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko

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
    #zfs.extraPools = ["zstorage"];
  };

  services.zfs = {
    trim.enable = true;
    autoScrub.enable = true;
  };

  hardware.nvidia = {
    nvidiaSettings = lib.mkForce false;
  };

  # Preserve space by sacrificing documentation
  documentation = {
    nixos.enable = false;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
