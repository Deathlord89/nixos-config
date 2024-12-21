{
  disko.devices = {
    disk = {
      main1 = {
        type = "disk";
        device = "/dev/disk/by-id/virtio-WD-WMAP9A966149";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "256M";
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
    };

    zpool = {
      zroot = {
        type = "zpool";
        rootFsOptions = {
          acltype = "posixacl";
          dnodesize = "auto";
          canmount = "off";
          xattr = "sa";
          mountpoint = "none";
          compression = "zstd";
          "com.sun:auto-snapshot" = "false";
        };
        options = {
          ashift = "12";
          autotrim = "on";
        };
        datasets = {
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
          #"podman_volumes" = {
          #  type = "zfs_fs";
          #  mountpoint = "/var/lib/containers/storage/volumes";
          #  options = {
          #    mountpoint = "legacy";
          #  };
          #};
          "postgres" = {
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
            options = {
              mountpoint = "legacy";
            };
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
    };
  };
}
