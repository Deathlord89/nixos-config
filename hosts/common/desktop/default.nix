{desktop, ...}: {
  imports = [
    (./. + "/${desktop}.nix")

    ../hardware/pipewire.nix
    ../hardware/printer.nix
    ../hardware/yubikey.nix
  ];

  # Enable Plymouth and surpress some logs by default.
  boot.plymouth.enable = true;
  #boot.kernelParams = [
  #  # The 'splash' arg is included by the plymouth option
  #  "quiet"
  #  "loglevel=3"
  #  "rd.udev.log_priority=3"
  #  "vt.global_cursor_default=0"
  #];

  # Quiet boot with plymouth - supports LUKS passphrase entry if needed
  boot.kernelParams = [
    "quiet"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "boot.shell_on_fail"
  ];

  hardware.graphics.enable = true;

  programs = {
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
