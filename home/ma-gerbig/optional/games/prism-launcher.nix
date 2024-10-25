{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages =
    lib.mkIf (config.optional.games.enable_mangohud
      == true) [pkgs.prismlauncher];
}
