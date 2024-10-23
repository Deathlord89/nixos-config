{
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-3

    ../common/users/ma-gerbig

    ../common/base

    ../common/optional/wireless.nix
    #../common/optional/kodi.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  # Define your hostname
  networking.hostName = "IG-7B";

  ## Overrides
  # Bootloader.
  boot.loader = {
    systemd-boot.enable = lib.mkForce false;
    grub.enable = lib.mkForce false;
    generic-extlinux-compatible.enable = lib.mkForce true;
    raspberryPi.firmwareConfig = ''
      force_turbo=1
      hdmi_force_hotplug=1
      gpu_mem=256
      dtparam=audio=on
    '';
  };

  # Preserve space by sacrificing documentation and history
  documentation = {
    nixos.enable = false;
    man.enable = false;
  };

  boot.tmp.cleanOnBoot = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
