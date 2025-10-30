{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.productivity.emacs;
in {
  options.productivity.emacs = {
    enable = lib.mkEnableOption "enable emacs";
  };

  config = lib.mkIf cfg.enable {
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
      #restartTriggers = [
      # FIXME: this method is not working ...
      #"${config.home.homeDirectory}/.emacs.d/early-init.el"
      #"${config.home.homeDirectory}/.emacs.d/init.el"
      #"${config.home.file.".emacs.d/early-init.el".destination}"
      #"${config.home.file.".emacs.d/init.el".destination}"
      #];
    };

    home.file = {
      "${config.xdg.configHome}/emacs/early-init.el".source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/git/nixos-config/home/ma-gerbig/optional/emacs/early-init.el";

      "${config.xdg.configHome}/emacs/init.el".source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/git/nixos-config/home/ma-gerbig/optional/emacs/init.el";

      "${config.xdg.cacheHome}/emacs/straight/versions/default.el".source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/git/nixos-config/home/ma-gerbig/optional/emacs/straight-el/default.el";

      "${config.xdg.configHome}/emacs/themes/doom-stylix-theme.el".source = config.lib.stylix.colors {
        template = builtins.readFile ./themes/doom-stylix-theme.el.mustache;
        extension = ".el";
      };
    };

    home.packages = with pkgs; [
      # Straight.el
      python3
      watchexec

      # IDE
      nil

      # Doom-modeline symbols
      nerd-fonts.symbols-only
    ];

    # Clean up unwanted OS defaults
    home.activation = {
      deleteDotEmacs = lib.hm.dag.entryAfter ["writeBoundary"] ''
        DOTEMACS="${config.home.homeDirectory}/.emacs"
        DOTEMACSDIR="${config.home.homeDirectory}/.emacs.d"
        if [[ -e "$DOTEMACS" ]]; then
        rm -f "$DOTEMACS"
        fi

        if [[ -d "$DOTEMACSDIR" ]]; then
        rm -rf "$DOTEMACSDIR"
        fi
      '';
    };
  };
}
