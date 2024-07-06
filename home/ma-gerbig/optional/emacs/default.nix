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

  systemd.user.services.emacs = {
    serviceConfig = {
      TimeoutStartSec = "7min";
    };
  };

  home.file = {
    ".emacs.d/early-init.el".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/git/nixos-config/home/ma-gerbig/optional/emacs/early-init.el";

    ".emacs.d/init.el".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/git/nixos-config/home/ma-gerbig/optional/emacs/init.el";

    ".emacs.d/straight/versions/default.el".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/git/nixos-config/home/ma-gerbig/optional/emacs/straight-el/default.el";

    ".emacs.d/themes/doom-stylix-theme.el".source = config.lib.stylix.colors {
      template = builtins.readFile ./themes/doom-stylix-theme.el.mustache;
      extension = ".el";
    };
  };

  home.packages = with pkgs; [
    python3
    watchexec
  ];
}
