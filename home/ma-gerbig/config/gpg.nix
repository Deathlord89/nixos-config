{ config, pkgs, ... }:
# let
#   # Import the gpg key from keyserver.
#   gpgKey = pkgs.fetchurl {
#     url = "https://keyserver.ubuntu.com:443/pks/lookup?op=get&search=0x39cb130c67b92382";
#     sha256 = "qyAHw6ehf0XCySXQ55xO8zyk7MCZabKQyIjewjp7300=";
#   };
# in
{
  programs = {
    gpg ={
      enable = true;
      # publicKeys = [
      #   {source = "${gpgKey}"; trust = 5;}
      # ];
      scdaemonSettings = {
        disable-ccid = true;
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
      pinentryPackage = pkgs.pinentry-gnome3;
      defaultCacheTtl = 60;
      maxCacheTtlSsh = 120;
    };
  };
}
