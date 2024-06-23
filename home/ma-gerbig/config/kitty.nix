{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = [pkgs.kitty];

  programs.kitty = {
    enable = true;
    settings = {
      allow_remote_control = "no";
      background_opacity = "0.8";
      linux_display_server = "x11";
      term = "xterm-256color";
    };
  };
}
