{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/base
    ../common/hardware/yubikey.nix
    ../common/hardware/nvidia
    ../common/hardware/nvidia/optimus.nix

    ../../modules/sops.nix
    ../../modules/lanzaboote.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disko.nix
  ];

  # Bootloader btrfs support
  boot.supportedFilesystems = ["btrfs"];

  networking = {
    # Define your hostname.
    hostName = "T460p";
    # Enable networking
    networkmanager.enable = true;
    # Enables wireless support via wpa_supplicant.
    # wireless.enable = true;
  };

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
        kitty
        vscodium
      ];
    };
  };

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
