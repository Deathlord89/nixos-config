{
  pkgs,
  lib,
  myLib,
  config,
  outputs,
  stateVersion,
  username,
  ...
}: {
  imports = (myLib.scanPaths ./.) ++ (builtins.attrValues outputs.homeManagerModules);

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        #"ca-derivations" # FIXME: Only unstable
      ];
      #warn-dirty = false;
    };
  };

  home = {
    inherit username stateVersion;
    homeDirectory = "/home/${username}";

    # Add stuff for your user as you see fit:
    packages = with pkgs; [
      alejandra # Nix formatter
      btop
      mc
      wl-clipboard
      xclip
      neovim
    ];

    sessionVariables = {
      EDITOR = "nvim";
      NH_FLAKE = "$HOME/git/nixos-config";
    };
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
