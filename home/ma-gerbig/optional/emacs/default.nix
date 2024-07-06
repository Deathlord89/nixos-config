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
    restartTriggers = [
      (config.home.file ".emacs.d/early-init.el".target)
      (config.home.file ".emacs.d/init.el".target)
    ];
  };

  home.file = {
    ".emacs.d/early-init.el".source = ./early-init.el;

    ".emacs.d/init.el".source = ./init.el;

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
