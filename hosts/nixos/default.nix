# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  outputs,
  lib,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ../common/users/ma-gerbig

    ../common/base
    ../common/desktop/gnome.nix
    ../common/hardware/yubikey.nix

    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # Include the results of the hardware scan
    ./hardware-configuration.nix
  ];

  # Set your hostname
  networking.hostName = "nixos";

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = lib.mkForce false;
    grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = false;
    };
  };

  # Disable CUPS, fwupd
  services = {
    fwupd.enable = false;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
