{
  lib,
  config,
  pkgs,
  inputs,
  stateVersion,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ../common/users/ma-gerbig

    ../common/base
    ../common/desktop/gnome.nix
    ../common/hardware/yubikey.nix

    ../common/optional/flatpak.nix
    ../common/optional/libvirt.nix
    ../common/optional/printer.nix
    ../common/optional/steam.nix

    # Include host specific services
    ./services

    # Include the results of the hardware scan.
    ./disko.nix
    ./hardware-configuration.nix
  ];
  # Define your hostname
  networking.hostName = "NitroX";

  backup.restic.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  # Bootloader add btrfs support
  boot.supportedFilesystems = ["btrfs"];
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  #chaotic.mesa-git.enable = true;

  # Building for Rasoberry Pi
  #boot.binfmt.emulatedSystems = ["aarch64-linux"];

  system = {
    inherit stateVersion;
  };
}
