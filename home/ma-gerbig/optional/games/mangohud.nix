{
  lib,
  config,
  ...
}: let
  cfg = config.games.mangohud;
in {
  options.games.mangohud = {
    enable = lib.mkEnableOption "enable mangohud FPS overlay";
  };

  config = lib.mkIf cfg.enable {
    programs.mangohud = {
      enable = true;
      enableSessionWide = true;
      settings = {
        frame_timing = false;
        cpu_stats = true;
        cpu_temp = true;
        gpu_stats = true;
        gpu_temp = true;
        ram = true;
        vram = true;

        # Hide until toggled
        no_display = true;
        round_corners = "5";

        toggle_hud = "Shift_L+F1";
        toggle_hud_position = "Shift_L+F2";
        toggle_logging = "Shift_L+F3";
        reload_cfg = "Shift_L+F4";
      };
    };
  };
}
