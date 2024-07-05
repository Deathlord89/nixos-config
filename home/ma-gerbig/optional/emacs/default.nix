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
    "${config.xdg.configHome}/emacs/early-init.el".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/git/nixos-config/home/ma-gerbig/optional/emacs/early-init.el";

    "${config.xdg.configHome}/emacs/init.el".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/git/nixos-config/home/ma-gerbig/optional/emacs/init.el";

    "${config.xdg.configHome}/emacs/straight/versions/default.el".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/git/nixos-config/home/ma-gerbig/optional/emacs/default.el";
  };

  home.packages = with pkgs; [
    python3
    watchexec
  ];
}
