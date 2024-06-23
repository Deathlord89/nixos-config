{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./dconf.nix
    ./git.nix
    ./gpg.nix
    ./kitty.nix
  ];
  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.nerdfonts.override {fonts = ["FiraCode"];})
  ];
}
