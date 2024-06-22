{pkgs, ...}: {
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "firefox.desktop"
        "kitty.desktop"
        "alacritty.desktop"
        "codium.desktop"
      ];
      # 'gnome-extensions list' for a list
      enabled-extensions = [
        "caffeine@patapon.info"
        "dash-to-dock@micxgx.gmail.com"
      ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
      dynamic-workspaces = true;
    };
    # Extensions settings
    "org/gnome/shell/extensions/caffeine" = {
      indicator-position = -1;
      indicator-position-index = -1;
      screen-blank = "never";
      show-indicator = "only-active";
      show-notifications = false;
      toggle-shortcut = ["<Super>c"];
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-fixed = false;
      dock-position = "BOTTOM";
      height-fraction = 0.9;
      dash-max-icon-size = 48;
      preview-size-scale = 0.0;
      require-pressure-to-show = false;
      show-dock-urgent-notify = true;
      autohide = true;
      show-favorites = true;
      show-trash = false;
      show-mounts = true;
      show-mounts-only-mounted = true;
      show-mounts-network = false;
      custom-theme-shrink = true;
      apply-custom-theme = true;
    };
  };

  home = {
    packages = with pkgs; [
      gnomeExtensions.caffeine
      gnomeExtensions.dash-to-dock
    ];
  };
}
