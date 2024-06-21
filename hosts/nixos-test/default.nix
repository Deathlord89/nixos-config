{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/base
    ../common/hardware/yubikey.nix

    ../../modules/sops.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-test"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  services = {
    xserver = {
      enable = true;
      # Configure keymap in X11
      xkb = {
        layout = "de";
        variant = "";
      };
      displayManager = {
        gdm.enable = true;
      };
      desktopManager = {
        gnome.enable = true;
      };
    };
  };

  # List services that you want to enable:

  # Enable CUPS to print documents.
  services.printing.enable = false;

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  sops.secrets."user/ma-gerbig/password".neededForUsers = true;
  users = {
    #mutableUsers = false;
    users.ma-gerbig = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."user/ma-gerbig/password".path;
      description = "Marc-André Gerbig";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [
        alacritty
        alejandra
        kitty
        vscodium
        wezterm
      ];
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    neovim
    sops
    wget
  ];

  services.fwupd.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
