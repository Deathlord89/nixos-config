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
    ../common/desktop/gnome.nix
    ../common/hardware/yubikey.nix
    ../common/hardware/nvidia

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
  networking.hostName = "Maximus";

  backup.restic.enable = true;

  #boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  # Bootloader add btrfs support
  boot.supportedFilesystems = ["btrfs"];
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  # Building for Rasoberry Pi
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  # Override Nvidia driver package
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
  #  version = "565.57.01";
  #  sha256_64bit = "sha256-buvpTlheOF6IBPWnQVLfQUiHv4GcwhvZW3Ks0PsYLHo=";
  #  sha256_aarch64 = "sha256-buvpTlheOF6IBPWnQVLfQUiHv4GcwhvZW3Ks0PsYLHo=";
  #  openSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
  #  settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
  #  persistencedSha256 = lib.fakeSha256;
  #};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
