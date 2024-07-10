{
  pkgs,
  lib,
  myLib,
  config,
  outputs,
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
    username = "ma-gerbig";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";

    # Add stuff for your user as you see fit:
    packages = with pkgs;
      [
        alejandra # Nix formatter
        btop
        wl-clipboard
        xclip
      ]
      ++ (with pkgs.unstable; [
        neovim
      ]);

    sessionVariables = {
      EDITOR = "nvim";
      FLAKE = "$HOME/git/nixos-config";
    };
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.05";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
