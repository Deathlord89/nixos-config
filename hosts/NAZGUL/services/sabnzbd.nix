{
  services.sabnzbd = {
    enable = true;
  };

  networking.firewall.allowedTCPPorts = [8081];
}
