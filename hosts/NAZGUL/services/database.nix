{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    postgresql = {
      enable = true;
      package = pkgs.postgresql_16;
      settings = {
        listen_addresses = lib.mkForce ""; # only allow access via unix socket

        # ZFS
        full_page_writes = "off";

        # PGTune
        max_connections = "200";
        shared_buffers = "3GB";
        effective_cache_size = "9GB";
        maintenance_work_mem = "768MB";
        checkpoint_completion_target = "0.9";
        wal_buffers = "16MB";
        default_statistics_target = "100";
        random_page_cost = "1.1";
        effective_io_concurrency = "200";
        work_mem = "1966kB";
        huge_pages = "off";
        min_wal_size = "1GB";
        max_wal_size = "4GB";
        max_worker_processes = "8";
        max_parallel_workers_per_gather = "4";
        max_parallel_workers = "8";
        max_parallel_maintenance_workers = "4";
      };
    };

    redis = {
      vmOverCommit = true;
    };
  };
}
