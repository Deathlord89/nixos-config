{pkgs, ...}: {
  gtk.enable = true;

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "firefox.desktop"
        "kitty.desktop"
        "codium.desktop"
      ];
      # 'gnome-extensions list' for a list
      enabled-extensions = [
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "dash-to-dock@micxgx.gmail.com"
        "gsconnect@andyholmes.github.io"
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        "pop-shell@system76.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
    };
    "org/gnome/desktop/interface" = {
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
      apply-custom-theme = false;
    };
  };

  home = {
    packages = with pkgs.gnomeExtensions; [
      blur-my-shell
      caffeine
      dash-to-dock
      gsconnect
      native-window-placement
      pop-shell
      user-themes
    ];
  };
}
