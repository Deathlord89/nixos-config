{
  pkgs,
  myLib,
  ...
}: {
  imports = myLib.scanPaths ./.;

  home.packages = with pkgs; [
    appimage-run
    discord
    filezilla
    mediainfo
    mediainfo-gui
    obsidian
    peazip
    thunderbird
    zotero
  ];
}
