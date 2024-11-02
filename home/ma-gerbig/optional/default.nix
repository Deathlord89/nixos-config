{
  pkgs,
  myLib,
  ...
}: {
  imports = myLib.scanPaths ./.;

  home.packages = with pkgs; [
    appimage-run
    brave
    filebot
    filezilla
    portfolio
    thunderbird
    vivaldi
    zotero
  ];
}
