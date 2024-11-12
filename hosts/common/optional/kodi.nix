{
  pkgs,
  lib,
  ...
}: let
  myKodi = pkgs.kodi-wayland.withPackages (pkgs:
    #myKodi = pkgs.kodi.withPackages (pkgs:
      with pkgs; [
        jellyfin
        #netflix
      ]);
in {
  # create Kodi user
  users.users.kodi = {
    isNormalUser = true;
    extraGroups = ["video"]; # for access to HDMI CEC device
  };

  services = {
    # disable greetd, as cage starts directly
    greetd.enable = lib.mkForce false;

    # cage is compositor and "login manager" that starts a single program: Kodi
    cage = {
      enable = true;
      user = "kodi";
      program = "${myKodi}/bin/kodi-standalone";
      environment = {
        XKB_DEFAULT_LAYOUT = "de";
        XKB_DEFAULT_VARIANT = "nodeadkeys";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [8080]; # for web interface / remote control

  services.udev.extraRules = ''
    # allow access to raspi cec device for video group (and optionally register it as a systemd device, used below)
    KERNEL=="vchiq", GROUP="video", MODE="0660", TAG+="systemd", ENV{SYSTEMD_ALIAS}="/dev/vchiq"
  '';

  # Attach a persisted cec-client to `/run/cec.fifo`, to avoid the CEC ~1s startup delay per command
  # scan for devices: `echo 'scan' > /run/cec.fifo ; journalctl -u cec-client.service`
  # set pi as active source: `echo 'as' > /run/cec.fifo`
  systemd.sockets."cec-client" = {
    after = ["dev-vchiq.device"];
    bindsTo = ["dev-vchiq.device"];
    wantedBy = ["sockets.target"];
    socketConfig = {
      ListenFIFO = "/run/cec.fifo";
      SocketGroup = "video";
      SocketMode = "0660";
    };
  };
  systemd.services."cec-client" = {
    after = ["dev-vchiq.device"];
    bindsTo = ["dev-vchiq.device"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = ''${pkgs.libcec}/bin/cec-client -d 1'';
      ExecStop = ''/bin/sh -c "echo q > /run/cec.fifo"'';
      StandardInput = "socket";
      StandardOutput = "journal";
      Restart = "no";
    };
  };

  # install libcec for manual usage, which includes cec-client (requires root or "video" group, see udev rule below)
  # scan for devices: `echo 'scan' | cec-client -s -d 1`
  # set pi as active source: `echo 'as' | cec-client -s -d 1`
  #environment.systemPackages = with pkgs; [
  #  libcec
  #];
}
#{
#  services.xserver = {
#    enable = true;
#    desktopManager.kodi = {
#      enable = true;
#      package = pkgs.kodi.withPackages (pkgs:
#        with pkgs; [
#           jellyfin
#          #netflix
#        ]);
#    };
#    displayManager = {
#      autoLogin = {
#        enable = true;
#        user = "kodi";
#      };
#      lightdm.greeter.enable = false;
#    };
#  };
#
#  # Define a user account
#  #users.extraUsers.kodi.isNormalUser = true;
#}

