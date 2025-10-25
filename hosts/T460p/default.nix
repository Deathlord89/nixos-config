{
  config,
  pkgs,
  inputs,
  stateVersion,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t460p

    ../common/users/ma-gerbig

    ../common/base
    ../common/desktop/gnome.nix
    ../common/hardware/yubikey.nix
    ../common/hardware/nvidia
    ../common/hardware/nvidia/optimus.nix

    ../common/optional/flatpak.nix
    ../common/optional/lanzaboote.nix
    ../common/optional/printer.nix
    ../common/optional/steam.nix
    ../common/optional/wireless.nix

    # Include host specific services
    ./services

    # Include the results of the hardware scan.
    ./disko.nix
    ./hardware-configuration.nix
  ];
  # Define your hostname
  networking.hostName = "T460p";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader add btrfs support
  boot.supportedFilesystems = ["btrfs"];
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  system = {
    inherit stateVersion;
  };
}
