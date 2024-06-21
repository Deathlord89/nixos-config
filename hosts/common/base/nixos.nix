{
  config,
  pkgs,
  lib,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # NixOS relatet settings
  nix = {
    # Enable the Flakes feature and the accompanying new nix command-line tool
    settings.experimental-features = ["nix-command" "flakes"];
    # Perform garbage collection weekly to maintain low disk usage
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    # We have flakes!
    #channel.enable = false;
  };
}