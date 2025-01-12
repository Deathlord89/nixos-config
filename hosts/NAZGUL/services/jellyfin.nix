{config, ...}: let
  mediaGroup = "media";
in {
  users.groups.${mediaGroup} = {
    members = [
      "${config.services.jellyfin.user}"
    ];
  };

  sops.secrets = {
    "jdownloader/env.enc" = {
      sopsFile = ../secrets.yaml;
      restartUnits = ["podman-jdownloader2.service"];
    };
  };

  services = {
    jellyfin = {
      enable = true;
      group = mediaGroup;
      openFirewall = true;
    };
    sabnzbd = {
      enable = true;
      group = mediaGroup;
    };
  };

  virtualisation.oci-containers = {
    containers = {
      "jdownloader2" = {
        image = "docker.io/jaymoulin/jdownloader";
        autoStart = true;
        user = "${builtins.toString config.users.users.sabnzbd.uid}:${builtins.toString config.users.groups.${mediaGroup}.gid}";
        environmentFiles = ["${config.sops.secrets."jdownloader/env.enc".path}"];
        ports = ["3129:3129/tcp"];
        volumes = [
          "jdownloader_app:/opt/JDownloader/app:rw"
          "/var/lib/JDownloader:/opt/JDownloader/app/cfg:rw"
          "/var/media/downloads:/opt/JDownloader/Downloads:rw"
          "/var/media/videos/neu:/opt/JDownloader/Extract:rw"
          "/etc/localtime:/etc/localtime:ro"
        ];
        labels = {"io.containers.autoupdate" = "registry";};
        log-driver = "journald";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [3129 8081];
}
