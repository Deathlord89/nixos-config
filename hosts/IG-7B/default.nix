{
  lib,
  inputs,
  stateVersion,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-3

    ../common/users/ma-gerbig

    ../common/base

    ../common/optional/wireless.nix
    ../common/optional/kodi.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  # Define your hostname
  networking.hostName = "IG-7B";

  ## Overrides
  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = lib.mkForce false;
      grub.enable = lib.mkForce false;
      generic-extlinux-compatible.enable = lib.mkForce true;
      raspberryPi.firmwareConfig = ''
        dtparam=audio=on
        force_turbo=1
        gpu_mem=256
        hdmi_force_hotplug=1
      '';
    };
    #kernelParams = ["cma=320M"];
    kernelParams = ["cma=256M"];
  };

  # Enable R-Pi3 graphics
  hardware = {
    graphics.enable = true;
  };

  # Preserve space by sacrificing documentation and history
  documentation = {
    nixos.enable = false;
    man.enable = false;
  };

  boot.tmp.cleanOnBoot = true;

  system = {
    inherit stateVersion;
  };
}
