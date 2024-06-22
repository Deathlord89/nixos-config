{
  config,
  pkgs,
  lib,
  ...
}: {
  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curl
    git
    lm_sensors
    neovim
    pciutils
    usbutils
    wget
  ];
  # Exclude XTerm
  services.xserver.excludePackages = [pkgs.xterm];

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
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

  # Enable in-memory compressed swap device
  zramSwap.enable = true;

  # List services that you want to enable:
  services = {
    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no"; # disable root login
        # PasswordAuthentication = false; # disable password login
      };
    };
    fwupd.enable = lib.mkDefault true;
    # Enable CUPS to print documents.
    printing.enable = lib.mkDefault true;
  };
}
