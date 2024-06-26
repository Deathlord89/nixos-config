{
  pkgs,
  myLib,
  ...
}: {
  imports = myLib.scanPaths ./.;

  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];
}
