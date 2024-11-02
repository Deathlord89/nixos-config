{
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
    ../common/optional/gamemode.nix
    ../common/optional/libvirt.nix
    ../common/optional/printer.nix

    ./services/syncthing.nix

    # Include the results of the hardware scan.
    ./disko.nix
    ./hardware-configuration.nix
  ];
  # Define your hostname
  networking.hostName = "Maximus";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader add btrfs support
  boot.supportedFilesystems = ["btrfs"];
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

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
