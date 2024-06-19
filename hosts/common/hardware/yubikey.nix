# Reference:
# https://rzetterberg.github.io/yubikey-gpg-nixos.html
{ config, pkgs, lib, ... }:

{
  programs.ssh.startAgent = false;

  # https://discourse.nixos.org/t/gpg-smartcard-for-ssh/33689
  hardware.gpgSmartcards.enable = true; # for yubikey

  environment.systemPackages = with pkgs; [
    gnupg
    yubikey-personalization
  ];

  services = {
    pcscd.enable = true;
    udev.packages = with pkgs; [
      yubikey-personalization
    ];
    gnome.gnome-keyring.enable = lib.mkForce false;
  };
}