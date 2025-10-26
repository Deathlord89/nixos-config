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

  hardware.enableRedistributableFirmware = true;

  services.fwupd.enable = lib.mkDefault true;
}
