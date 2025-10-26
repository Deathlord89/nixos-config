{
  pkgs,
  lib,
  ...
}: {
  # Install fish shell for global completions
  programs.fish.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curl
    git
    htop
    lm_sensors
    pciutils
    usbutils
    wget
  ];

  # Exclude XTerm
  services.xserver.excludePackages = [pkgs.xterm];

  # Hibernate and hybrid-sleep won't work correctly without
  # an on-disk swap.
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # Enable in-memory compressed swap device
  zramSwap.enable = true;

  hardware.enableRedistributableFirmware = true;

  services.fwupd.enable = lib.mkDefault true;
}
