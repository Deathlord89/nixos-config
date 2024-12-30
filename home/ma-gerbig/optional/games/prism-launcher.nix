{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.games.prismlauncher;
in {
  options.games.prismlauncher = {
    enable = lib.mkEnableOption "enable prismlauncher";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [prismlauncher];
  };
}
