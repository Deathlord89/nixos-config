{
  config,
  pkgs,
  lib,
  ...
}: {
  sops.secrets = {
    "paperless/adminpass" = {
      sopsFile = ../secrets.yaml;
      owner = "paperless";
    };
    "paperless/web_env.enc" = {
      sopsFile = ../secrets.yaml;
      owner = "paperless";
    };
    "paperless/ftp_env.enc" = {
      sopsFile = ../secrets.yaml;
      restartUnits = ["podman-paperless-ftp-server.service"];
    };
  };

  services = {
    paperless = {
      enable = true;
      package = pkgs.paperless-ngx;

      address = "0.0.0.0";
      port = 8083;
      dataDir = "/var/lib/paperless";
      mediaDir = "/var/media/documents/paperless";
      consumptionDir = "/var/media/documents/consume";
      consumptionDirIsPublic = true;

      passwordFile = "${config.sops.secrets."paperless/adminpass".path}";
      environmentFile = "${config.sops.secrets."paperless/web_env.enc".path}";
      settings = {
        PAPERLESS_DBHOST = "/run/postgresql";
        PAPERLESS_REDIS = "unix://${config.services.redis.servers.paperless.unixSocket}";
        PAPERLESS_URL = "https://paperless.ma-gerbig.de";
        PAPERLESS_SECRET_KEY = "";
        PAPERLESS_TIME_ZONE = "Europe/Berlin";

        PAPERLESS_CONSUMER_RECURSIVE = true;
        PAPERLESS_CONSUMER_IGNORE_PATTERN = [
          ".DS_STORE/*"
          "desktop.ini"
        ];

        PAPERLESS_OCR_LANGUAGE = "deu+eng";
        PAPERLESS_OCR_MODE = "skip";
        PAPERLESS_FILENAME_FORMAT = "{{created_year}}/{{correspondent}}/{{created_year}}-{{created_month}}-{{created_day}} {{asn}} {{correspondent}} {{document_type}} {{title}}";
        PAPERLESS_FILENAME_FORMAT_REMOVE_NONE = "true";

        PAPERLESS_TIKA_ENABLED = "1";
        #PAPERLESS_TIKA_GOTENBERG_ENDPOINT = "http://localhost:${toString config.services.gotenberg.port}";
        PAPERLESS_TIKA_GOTENBERG_ENDPOINT = "http://localhost:3000";
        PAPERLESS_TIKA_ENDPOINT = "http://${config.services.tika.listenAddress}:${toString config.services.tika.port}";
      };
    };

    #gotenberg = {
    #  enable = true;
    #  #timeout = "300s";
    #};

    tika.enable = true;

    postgresql = {
      ensureUsers = [
        {
          name = "paperless";
          ensureDBOwnership = true;
        }
      ];
      ensureDatabases = ["paperless"];
    };

    redis.servers.paperless = {
      enable = true;
      appendOnly = true;
    };
  };

  virtualisation.oci-containers = {
    containers = {
      "gotenberg" = {
        image = "docker.io/gotenberg/gotenberg:8";
        autoStart = true;
        ports = ["127.0.0.1:3000:3000"];
        cmd = ["gotenberg" "--chromium-disable-javascript=true" "--chromium-allow-list=file:///tmp/.*"];
        labels = {"io.containers.autoupdate" = "registry";};
        log-driver = "journald";
      };
      "paperless-ftp-server" = {
        image = "docker.io/garethflowers/ftp-server:latest";
        autoStart = true;
        environment = {
          FTP_USER = "paperless";
        };
        environmentFiles = ["${config.sops.secrets."paperless/ftp_env.enc".path}"];
        ports = ["20-21:20-21"];
        volumes = [
          "/var/media/documents/consume:/home/paperless/consume"
        ];
        labels = {"io.containers.autoupdate" = "registry";};
        log-driver = "journald";
      };
    };
  };

  users.users.paperless.extraGroups = ["redis-paperless"];
  networking.firewall.allowedTCPPorts = [8083];
}
