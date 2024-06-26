{pkgs, ...}: let
  font = "JetBrainsMono NF";
  icon = pkgs.fetchurl {
    url = "https://github.com/DinkDonk/kitty-icon/blob/main/kitty-dark.png?raw=true";
    sha256 = "McF0F74s6scdwNc+QSubVDk1PRD/4YiTI1iFju3LynA=";
  };
in {
  xdg.dataFile."icons/hicolor/256x256/apps/kitty.png".source = icon;
  xdg.dataFile."icons/hicolor/scalable/apps/kitty.png".source = icon;

  programs.kitty = {
    enable = true;
    settings = {
      allow_remote_control = "no";
      background_opacity = "0.85";
      linux_display_server = "x11";
      term = "xterm-256color";

      # Font Settings
      font_size = "11.0";
      font_family = "${font}";
      #bold_font = "${font} Bold";
      #italic_font = "${font} Italic";
      #bold_italic_font = "${font} Bold Italic";
      disable_ligatures = "cursor";
      confirm_os_window_close = "-1";

      # Temporary theme settings. TODO remove when using stylix
      # Basic colors
      foreground = "#d8dee9";
      background = "#2e3440";
      selection_foreground = "#d8dee9";
      selection_background = "#434c5e";

      # Cursor colors
      cursor = "#d8dee9";
      cursor_text_color = "#3b4252";

      # URL underline color when hovering with mouse
      url_color = "#0087bd";

      # Window border colors and terminal bell colors
      active_border_color = "#81a1c1";
      inactive_border_color = "#4c566a";
      bell_border_color = "#88c0d0";
      visual_bell_color = "none";

      # Tab bar colors
      active_tab_foreground = "#3b4252";
      active_tab_background = "#88c0d0";
      inactive_tab_foreground = "#e5e9f0";
      inactive_tab_background = "#4c566a";
      tab_bar_background = "#3b4252";
      tab_bar_margin_color = "none";

      # Mark colors (marked text in the terminal)
      mark1_foreground = "#3b4252";
      mark1_background = "#88c0d0";
      mark2_foreground = "#3b4252";
      mark2_background = "#bf616a";
      mark3_foreground = "#3b4252";
      mark3_background = "#ebcb8b";

      # The basic 16 colors
      # black
      color0 = "#3b4252";
      color8 = "#4c566a";

      # red
      color1 = "#bf616a";
      color9 = "#bf616a";

      # green
      color2 = "#a3be8c";
      color10 = "#a3be8c";

      # yellow
      color3 = "#ebcb8b";
      color11 = "#d08770";

      # blue
      color4 = "#81a1c1";
      color12 = "#5e81ac";

      # magenta
      color5 = "#b48ead";
      color13 = "#b48ead";

      # cyan
      color6 = "#88c0d0";
      color14 = "#8fbcbb";

      # white
      color7 = "#e5e9f0";
      color15 = "#eceff4";
    };
  };
}
