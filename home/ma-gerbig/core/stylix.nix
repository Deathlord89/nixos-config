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

  stylix.polarity = themePolarity;
  stylix.image = pkgs.fetchurl {
    url = backgroundUrl;
    sha256 = backgroundSha256;
  };

  stylix.base16Scheme = ./. + themePath;

  stylix.cursor = {
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
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
