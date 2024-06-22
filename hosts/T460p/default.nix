{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/base
    ../common/desktop/gnome.nix
    ../common/hardware/yubikey.nix
    ../common/hardware/nvidia
    ../common/hardware/nvidia/optimus.nix

    ../../modules/sops.nix
    ../../modules/lanzaboote.nix

    # Include the results of the hardware scan.
    ./disko.nix
    ./hardware-configuration.nix
  ];
  # Define your hostname
  networking.hostName = "T460p";

  # Bootloader add btrfs support
  boot.supportedFilesystems = ["btrfs"];

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
        btop
        vscodium
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
