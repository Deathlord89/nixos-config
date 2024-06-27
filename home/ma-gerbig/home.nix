# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  # You can import other home-manager modules here
  imports = [
    ./core
    ./optional/kitty.nix
    ./optional/gtk.nix
    ./optional/vscodium.nix
  ];
}
