{
  config,
  pkgs,
  ...
}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs; # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
  };

  services.emacs = {
    enable = true;
    startWithUserSession = "graphical";
  };

  home.file = {
    "${config.xdg.configHome}/emacs/early-init.el".source = ./early-init.el;
    "${config.xdg.configHome}/emacs/init.el".source = ./init.el;
  };
}
