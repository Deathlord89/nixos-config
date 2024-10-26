{
  pkgs,
  myLib,
  ...
}: {
  imports = myLib.scanPaths ./.;

  home.packages = with pkgs; [
    brave
    filebot
    filezilla
    portfolio
    thunderbird
    zotero
  ];
}
