# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    ./core
    ./optional/kitty.nix
    ./optional/gtk.nix
  ];

  home = {
    username = "ma-gerbig";
    homeDirectory = "/home/ma-gerbig";

    # Add stuff for your user as you see fit:
    packages = with pkgs;
      [
        alejandra # Nix formatter
        btop
        vscodium # TODO make optional
        wl-clipboard
        xclip
      ]
      ++ (with pkgs.unstable; [
        neovim
      ]);

    sessionVariables = {
      EDITOR = "nvim";
      #FLAKE=/home/ma-gerbig/git/nixos-config
    };
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
