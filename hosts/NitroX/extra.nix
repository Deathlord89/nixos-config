{
  imports = [
    ../common/optional/flatpak.nix
    ../common/optional/libvirt.nix
    ../common/optional/steam.nix
  ];

  backup.restic.enable = true;
}
