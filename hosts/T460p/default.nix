{ config, pkgs, ... }:

{
  imports = [
    ../common/hardware/yubikey.nix
    ../common/hardware/nvidia
    ../common/hardware/nvidia/optimus.nix

    ../../modules/sops.nix
    ../../modules/lanzaboote.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disko.nix
  ];

  # Bootloader.
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = true;
	  configurationLimit = 5;
      };
      timeout = 1;
    };
    #bootspec.enable = true;
    supportedFilesystems = [ "btrfs" ];
    #kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  };


  networking = {
    # Define your hostname.
    hostName = "T460p";
    # The 32-bit host ID of the machine
    # needed for zfs
    #hostId = "d5a98f2e";
    # Enable networking
    networkmanager.enable = true;
    # Enables wireless support via wpa_supplicant.
    # wireless.enable = true;
  };

  # Nix Settings
  nix = {
    # Enable the Flakes feature and the accompanying new nix command-line tool
    settings.experimental-features = [ "nix-command" "flakes" ];
    # Perform garbage collection weekly to maintain low disk usage
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    # We have flakes!
    channel.enable = false;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "de_DE.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  # Configure console keymap
  console.keyMap = "de";

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ma-gerbig = {
    isNormalUser = true;
    description = "Marc-André Gerbig";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    firefox
    git
    curl
    wget
    btop
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  # Enable in-memory compressed swap device
  zramSwap.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
