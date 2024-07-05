{
  pkgs,
  lib,
  ...
}: let
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
      #background_opacity = lib.mkForce "0.85";
      linux_display_server = "x11";
      term = "xterm-256color";

      # Font Settings
      #font_size = "11.0";
      disable_ligatures = "cursor";

      confirm_os_window_close = "-1";
    };
  };
}
