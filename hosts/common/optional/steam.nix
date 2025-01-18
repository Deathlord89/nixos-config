{
  inputs,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  umu = inputs.umu.packages.${system}.umu.override {
    version = inputs.umu.shortRev;
    truststore = true;
    cbor2 = true;
  };
in {
  #TODO Create module to automatically activate 32-bit drivers and gamemode when a game-related configuration is used

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      extraCompatPackages = with pkgs; [proton-ge-custom];
    };

    gamemode = {
      enable = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 4;
          ioprio = 0;
          inhibit_screensaver = 1;
        };
      };
    };
  };

  environment.systemPackages = [umu];

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
