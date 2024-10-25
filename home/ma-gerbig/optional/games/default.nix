{
  lib,
  myLib,
  ...
}: {
  imports = myLib.scanPaths ./.;

  options = {
    optional.games = {
      enable_mangohud = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      enable_prismlauncher = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };
}
