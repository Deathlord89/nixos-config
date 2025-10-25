{
  imports = [
    ../common/desktop/gnome.nix

    ../common/optional/flatpak.nix
    ../common/optional/libvirt.nix
    ../common/optional/printer.nix
    ../common/optional/steam.nix
  ];

  backup.restic.enable = true;
}
