{pkgs, ...}: {
  #TODO Create module to automatically activate 32-bit drivers and gamemode when a game-related configuration is used

  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      extraPackages = with pkgs; [unzip];
      extraCompatPackages = with pkgs; [
        proton-ge-bin # Nixos repo
        steamtinkerlaunch # General tweaks for games
      ];
    };

    gamemode = {
      enable = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 4;
          ioprio = 0;
          inhibit_screensaver = 1;
          disable_splitlock = 1;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    #ludusavi # Backing up your PC video game saves
    protonup-qt # Install and manage GE-Proton
    umu-launcher # Make Steam Linux Runtime available outside of Steam
  ];

  # Enable 32 bit OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Fix for Starcitizen
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };
}
