{pkgs, ...}: {
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [
          "--filter=until=24h"
          "--filter=label!=important"
        ];
      };
      # Required for container networking to be able to use names.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  networking.firewall.interfaces.podman1 = {
    allowedUDPPorts = [53]; # this needs to be there so that containers can look eachother's names up over DNS
  };

  environment.systemPackages = with pkgs; [
    podman-compose
    #podman-tui
  ];
}
