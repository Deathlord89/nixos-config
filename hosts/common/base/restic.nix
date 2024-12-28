{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.backup.restic;
in {
  options.backup.restic = {
    enable = lib.mkEnableOption "enable restic jobs";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets = {
      "restic/pass" = {};
      "restic/rclone.conf" = {
        path = "/root/.config/rclone/rclone.conf";
      };
    };

    environment.systemPackages = with pkgs; [
      restic
      rclone
    ];
  };
}
