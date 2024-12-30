{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.games.lutris;
in {
  options.games.lutris = {
    enable = lib.mkEnableOption "enable lutris games manager";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [lutris];
  };
}
