{pkgs, ...}: {
  # Enable CUPS to print documents
  services.printing = {
    enable = true;
    drivers = [pkgs.epson-escpr2]; # FIXME Drivers must be specified manually in Cups?
  };

  # Enable autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
}
