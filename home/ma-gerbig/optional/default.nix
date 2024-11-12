{
  pkgs,
  myLib,
  ...
}: {
  imports = myLib.scanPaths ./.;

  home.packages = with pkgs; [
    appimage-run
    brave
    discord
    filebot
    filezilla
    thunderbird
    zotero
  ];
}
