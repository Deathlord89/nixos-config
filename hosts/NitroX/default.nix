{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko

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

  # display AMD GPU
  environment.systemPackages = with pkgs; [amdgpu_top];

  chaotic.mesa-git.enable = true;

  # Building for Rasoberry Pi
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
