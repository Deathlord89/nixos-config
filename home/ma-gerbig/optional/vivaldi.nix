{pkgs, ...}: let
  vivaldi-codec = pkgs.vivaldi.override {
    proprietaryCodecs = true;
    enableWidevine = true;
  };
in {
  home.packages = [vivaldi-codec];
}
