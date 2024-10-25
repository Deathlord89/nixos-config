{
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        softrealtime = "on";
        renice = 4;
        ioprio = 0;
        inhibit_screensaver = 1;
      };
      #gpu = {
      #  apply_gpu_optimisations = "accept-responsibility";
      #  gpu_device = 0;
      #  nv_powermizer_mode = 1;
      #};
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Fix for Starcitizen
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };
}