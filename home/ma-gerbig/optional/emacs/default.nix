{pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs; # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
  };

  services.emacs = {
    enable = true;
    startWithUserSession = "graphical";
  };
}
