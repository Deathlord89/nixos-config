{pkgs, ...}: {
  # Enable the GNOME Desktop Environment.
  services = {
    xserver.enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    # Mount, trash, and other functionalities
    gvfs.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      gnome-tweaks
      pinentry-gnome3
    ];

    #Excluding some GNOME applications from the default install
    gnome.excludePackages = with pkgs; [
      #evince # document viewer
      #gnome-characters
      decibels # audio player
      epiphany # web browser
      geary # email reader
      gnome-music
      gnome-tour
      totem # video player
    ];
  };
  programs = {
    dconf.enable = true;
  };
}
