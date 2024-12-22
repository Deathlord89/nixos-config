{
  pkgs,
  config,
  ...
}: {
  sops.secrets = {
    "nextcloud/adminpass" = {
      sopsFile = ../secrets.yaml;
      owner = "nextcloud";
    };
    "nextcloud/secrets.file" = {
      sopsFile = ../secrets.yaml;
      owner = "nextcloud";
    };
  };

  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud30;
      hostName = "cloud.ma-gerbig.de";
      # home dir is default: /var/lib/nextcloud
      datadir = "/var/cloud";
      database.createLocally = false;
      configureRedis = false;
      secretFile = "${config.sops.secrets."nextcloud/secrets.file".path}";
      maxUploadSize = "20G";
      phpOptions = {
        "opcache.interned_strings_buffer" = "32";
      };

      config = {
        dbtype = "pgsql";
        dbhost = "/run/postgresql";
        dbname = "nextcloud";
        dbuser = "nextcloud";

        adminuser = "admin";
        adminpassFile = "${config.sops.secrets."nextcloud/adminpass".path}";
      };

      # this only loads the modules, config is below in extraOptions
      caching = {
        apcu = true;
        memcached = false;
        redis = true;
      };

      settings = {
        # caching
        "redis"."host" = "/run/redis-nextcloud/redis.sock";
        "memcache.local" = "\\OC\\Memcache\\APCu";
        "memcache.distributed" = "\\OC\\Memcache\\Redis";
        "memcache.locking" = "\\OC\\Memcache\\Redis"; # this must be Redis to avoid data loss

        # email sending
        "mail_smtpmode" = "smtp";
        "mail_smtpsecure" = "ssl";
        "mail_smtpauth" = "1";
        "mail_sendmailmode" = "smtp";
        "mail_smtpport" = "465";
        # mail_smtppassword is set via secretFile

        log_type = "errorlog";
        loglevel = 1;

        overwriteprotocol = "https";
        trusted_proxies = ["192.168.1.1"];
        "overwrite.cli.url" = "http://cloud.ma-gerbig.de";

        "maintenance_window_start" = "1"; # run daily jobs between 01:00 and 05:00 UTC
        default_phone_region = "DE"; # this sets the default country code for phone numbers, here +49

        "trashbin_retention_obligation" = "30, 90";
      };
    };

    postgresql = {
      ensureUsers = [
        {
          name = "nextcloud";
          ensureDBOwnership = true;
        }
      ];
      ensureDatabases = ["nextcloud"];
    };

    redis.servers.nextcloud = {
      enable = true;
      appendOnly = true;
    };

    nginx.virtualHosts.${config.services.nextcloud.hostName} = {
      listen = [
        {
          addr = "0.0.0.0";
          port = 8080;
        }
      ];
    };
  };

  users.users.nextcloud.extraGroups = ["redis-nextcloud"];
  networking.firewall.allowedTCPPorts = [8080];

  systemd.services.nextcloud-setup = {
    after = [
      "postgresql.service"
      "redis-nextcloud.service"
    ];
    requires = [
      "postgresql.service"
      "redis-nextcloud.service"
    ];
  };
}
