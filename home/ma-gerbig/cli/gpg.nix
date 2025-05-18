{
  pkgs,
  config,
  ...
}: {
  programs = {
    gpg = {
      enable = true;
      publicKeys = [
        {
          source = ../gpg.asc;
          trust = 5;
        }
      ];
      scdaemonSettings = {
        # Disabled when upgrading from 24.05 to unstable
        #reader-port = "Yubico Yubi";
        #disable-ccid = true;
      };
    };
  };

  services = {
    ssh-agent.enable = false;

    gpg-agent = {
      enable = true;
      enableExtraSocket = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableSshSupport = true;
      enableScDaemon = true;
      pinentry.package =
        if config.gtk.enable
        then pkgs.pinentry-gnome3
        else pkgs.pinentry-tty;
      defaultCacheTtl = 60;
      maxCacheTtlSsh = 120;
    };
  };
}
