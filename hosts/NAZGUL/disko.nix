{
  disko.devices = {
    disk = {
      root1 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WDC_WDS100T1R0C-68BDK0_24430R801246";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
      root2 = {
        type = "disk";
        device = "/dev/disk/by-id/ata-WDC_WDS100T1R0A-68A4W0_234808802347";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot2";
                mountOptions = ["umask=0077"];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };

      data1 = {
        type = "disk";
        device = "/dev/vdb";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zstorage";
              };
            };
          };
        };
      };
      data2 = {
        type = "disk";
        device = "/dev/vdc";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zstorage";
              };
            };
          };
        };
      };
      data3 = {
        type = "disk";
        device = "/dev/vdd";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zstorage";
              };
            };
          };
        };
      };
      data4 = {
        type = "disk";
        device = "/dev/vde";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zstorage";
              };
            };
          };
        };
      };
      data5 = {
        type = "disk";
        device = "/dev/vdf";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zstorage";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        mode = "mirror";
        rootFsOptions = {
          acltype = "posixacl";
          dnodesize = "auto";
          canmount = "off";
          xattr = "sa";
          mountpoint = "none";
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          #keylocation = "prompt";
          keylocation = "file:///tmp/pass-zpool-zroot";
          compression = "zstd";
          "com.sun:auto-snapshot" = "false";
        };
        postCreateHook = ''
          zfs set keylocation="prompt" zroot
        '';
        options = {
          ashift = "12";
          autotrim = "on";
        };
        datasets = {
          "cloud" = {
            type = "zfs_fs";
            mountpoint = "/srv/cloud";
            options = {
              mountpoint = "legacy";
            };
          };

          "home" = {
            type = "zfs_fs";
            mountpoint = "/home";
            options = {
              mountpoint = "legacy";
            };
          };
          "nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options = {
              atime = "off";
              mountpoint = "legacy";
            };
          };
          "containers" = {
            type = "zfs_fs";
            mountpoint = "/var/lib/containers";
            options = {
              mountpoint = "legacy";
              recordsize = "16K";
            };
          };
          "documents" = {
            type = "zfs_fs";
            mountpoint = "/srv/documents";
            options = {
              mountpoint = "legacy";
            };
          };
          "pgsql" = {
            type = "zfs_fs";
            mountpoint = "/var/lib/postgresql";
            options = {
              atime = "off";
              logbias = "throughput";
              mountpoint = "legacy";
              primarycache = "metadata";
              recordsize = "8K";
            };
          };
          "reserved" = {
            type = "zfs_fs";
            options = {
              mountpoint = "none";
              reservation = "10G";
            };
          };
          "root" = {
            type = "zfs_fs";
            mountpoint = "/";
            options.mountpoint = "legacy";
          };
          "var" = {
            type = "zfs_fs";
            mountpoint = "/var";
            options = {
              mountpoint = "legacy";
            };
          };
        };
      };

      zstorage = {
        type = "zpool";
        mode = "raidz1";
        rootFsOptions = {
          acltype = "posixacl";
          dnodesize = "auto";
          canmount = "off";
          xattr = "sa";
          mountpoint = "none";
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          #keylocation = "prompt";
          keylocation = "file:///tmp/pass-zpool-zstorage";
          compression = "zstd";
          "com.sun:auto-snapshot" = "false";
        };
        postCreateHook = ''
          zfs set keylocation="file:///root/pass-zpool-zstorage" zstorage
        '';
        options = {
          ashift = "12";
          autotrim = "on";
        };
        datasets = {
          "multimedia" = {
            type = "zfs_fs";
            mountpoint = "/srv/multimedia";
            options = {
              mountpoint = "legacy";
              recordsize = "1m";
            };
          };
          "multimedia/videos" = {
            type = "zfs_fs";
            mountpoint = "/srv/multimedia/videos";
            options = {
              mountpoint = "legacy";
              recordsize = "1m";
            };
          };
          "reserved" = {
            type = "zfs_fs";
            options = {
              mountpoint = "none";
              reservation = "100G";
            };
          };
        };
      };
    };
  };
}
