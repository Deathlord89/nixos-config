{pkgs, ...}: {
  # Enable the GNOME Desktop Environment.
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    # Mount, trash, and other functionalities
    gvfs.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      pinentry-gnome3
      gnome-tweaks
    ];

    #Excluding some GNOME applications from the default install
    gnome.excludePackages = with pkgs; [
      #evince # document viewer
      #gnome-characters
      epiphany # web browser
      geary # email reader
      gnome-music
      gnome-tour
      totem # video player
    ];
  };
  programs.dconf.enable = true;
}
