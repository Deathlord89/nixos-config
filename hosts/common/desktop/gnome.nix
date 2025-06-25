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
    gnome.gcr-ssh-agent.enable = false;
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
      decibels # audio player
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
        # "force_installed" and "normal_installe
        ExtensionSettings = with builtins; let
          extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        in
          listToAttrs [
            (extension "decentraleyes" "jid1-BoFifL9Vbdl2zQ@jetpack")
            (extension "multi-account-containers" "@testpilot-containers")
            (extension "sponsorblock" "sponsorBlocker@ajay.app")
            (extension "tabliss" "extension@tabliss.io")
            (extension "ublock-origin" "uBlock0@raymondhill.net")
          ];

        "*".installation_mode = "allowed";
      };
    };
  };
}
