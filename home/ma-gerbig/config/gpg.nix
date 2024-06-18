{ config, pkgs, ... }:

{
  programs = {
    gpg.scdaemonSettings = {
      disable-ccid = true;
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
      pinentryPackage = pkgs.pinentry-gnome3;
      defaultCacheTtl = 60;
      maxCacheTtlSsh = 120;
    };
  };
}
