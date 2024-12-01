# Reference:
# https://github.com/librephoenix/nixos-config/blob/main/user/style/stylix.nix
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  userTheme = "nord";
  themePath = "../../../../themes" + ("/" + userTheme + "/" + userTheme) + ".yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../../themes" + ("/" + userTheme) + "/polarity.txt"));
  backgroundUrl = builtins.readFile (./. + "../../../../themes" + ("/" + userTheme) + "/backgroundurl.txt");
  backgroundSha256 = builtins.readFile (./. + "../../../../themes" + ("/" + userTheme) + "/backgroundsha256.txt");
in {
  imports = [inputs.stylix.homeManagerModules.stylix];

  stylix.enable = true;

  stylix.targets = {
    emacs.enable = false;
    mangohud.enable = false;
  };

  stylix.polarity = themePolarity;
  stylix.image = pkgs.fetchurl {
    url = backgroundUrl;
    sha256 = backgroundSha256;
  };

  stylix.base16Scheme = ./. + themePath;

  stylix.cursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
  };

  stylix.opacity = {
    desktop = 1.0;
    popups = 0.95;
    terminal = 0.90;
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono NF";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-color-emoji;
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["JetBrainsMono NF"];
      sansSerif = ["DejaVu Sans"];
      serif = ["DejaVu Serif"];
    };
  };
}
