{
  config,
  pkgs,
  lib,
  ...
}: let
  font = "JetBrainsMono NFM";
in {
  programs.kitty = {
    enable = true;
    settings = {
      allow_remote_control = "no";
      background_opacity = "0.75";
      linux_display_server = "x11";
      term = "xterm-256color";
      font_size = "11.0";
      font_family = "${font}";
      bold_font = "${font} Bold";
      italic_font = "${font} Italic";
      bold_italic_font = "${font} Bold Italic";
    };
  };
}
