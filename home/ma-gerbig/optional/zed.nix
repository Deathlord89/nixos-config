{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.productivity.zed;
in {
  options.productivity.zed = {
    enable = lib.mkEnableOption "enable zed";
  };

  #stylix.targets.zed-editor.enable = false;

  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      extensions = [
        "nix"
      ];
      extraPackages = [pkgs.nixd];
      #extraPackages = [ pkgs.nil ];

      userSettings = {
        hour_format = "hour24";
        auto_update = false;
        load_direnv = "shell_hook";

        lsp = {
          nix = {
            binary = {
              path_lookup = true;
            };
            settings = {
              formatting = {
                command = ["alejandra"];
              };
            };
          };
        };
      };
    };
  };
}
