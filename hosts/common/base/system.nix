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

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };

  # Hibernate and hybrid-sleep won't work correctly without
  # an on-disk swap.
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # Enable in-memory compressed swap device
  zramSwap.enable = true;

  hardware.enableRedistributableFirmware = true;

  services.fwupd.enable = lib.mkDefault true;
}
