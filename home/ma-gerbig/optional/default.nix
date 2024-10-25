{
  pkgs,
  myLib,
  ...
}: {
  imports = myLib.scanPaths ./.;

  home.packages = with pkgs; [
    filezilla
    filebot
    portfolio
    zotero
    thunderbird
  ];
}
