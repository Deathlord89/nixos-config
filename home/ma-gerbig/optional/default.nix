{
  pkgs,
  myLib,
  ...
}: {
  imports = myLib.scanPaths ./.;

  home.packages = with pkgs; [
    appimage-run
    discord
    filebot
    filezilla
    mediainfo
    mediainfo-gui
    thunderbird
    zotero
  ];
}
