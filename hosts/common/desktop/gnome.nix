{pkgs, ...}: {
  # Enable the GNOME Desktop Environment.
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    # Mount, trash, and other functionalities
    gvfs.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      gnome-tweaks
      pavucontrol
      pinentry-gnome3
    ];

    #Excluding some GNOME applications from the default install
    gnome.excludePackages = with pkgs; [
      #evince # document viewer
      #gnome-characters
      epiphany # web browser
      geary # email reader
      gnome-music
      gnome-tour
      totem # video player
    ];
  };
  programs = {
    dconf.enable = true;
    firefox = {
      enable = true; # Install firefox.
      languagePacks = ["de" "en-US"];
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DontCheckDefaultBrowser = true;
        DisablePocket = true;
        SearchBar = "unified";
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        /*
        ---- EXTENSIONS ----
        */
        # Check about:support for extension/add-on ID strings.
        # Valid strings for installation_mode are "allowed", "blocked",
        # "force_installed" and "normal_installed".
        ExtensionSettings = {
          "*".installation_mode = "allowed";
          # Multi Account Containers:
          "@testpilot-containers" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
          };
          # Privacy Badger:
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
            installation_mode = "force_installed";
          };
          # SponsorBlocker:
          "sponsorBlocker@ajay.app" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          };
          # Tabliss:
          "extension@tabliss.io" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/3940751/tabliss-2.6.0.xpi";
            installation_mode = "force_installed";
          };
          # uBlock Origin:
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      };
    };
  };
}
