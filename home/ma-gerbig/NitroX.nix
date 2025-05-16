# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  # You can import other home-manager modules here
  imports = [
    ./cli
    ./optional
  ];

  games = {
    lutris.enable = true;
    mangohud.enable = true;
    prismlauncher.enable = true;
  };

  productivity = {
    latex.enable = true;
  };
}
