{lib, ...}: {
  # You can import other NixOS modules here
  imports = [
    ../common/users/ma-gerbig

    ../common/base
    ../common/desktop/gnome.nix
    ../common/hardware/yubikey.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  # Define your hostname
  networking.hostName = "nixos-test";

  ## Overrides
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
    printing.enable = false;
    fwupd.enable = false;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05"; # Did you read the comment?
}
