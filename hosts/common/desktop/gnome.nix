{
  config,
  pkgs,
  lib,
  ...
}: {
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
    systemPackages =
      (with pkgs; [
        pinentry-gnome3
      ])
      ++ (with pkgs.gnome; [
        gnome-tweaks
      ]);

    #Excluding some GNOME applications from the default install
    gnome.excludePackages =
      (with pkgs; [
        #gedit # text editor
        #gnome-photos
        #gnome-tour
      ])
      ++ (with pkgs.gnome; [
        #atomix # puzzle game
        #cheese # webcam tool
        #epiphany # web browser
        #evince # document viewer
        #geary # email reader
        #gnome-characters
        #gnome-music
        #hitori # sudoku game
        #iagno # go game
        #tali # poker game
        #totem # video player
      ]);
  };
}
