# Reference:
# https://rzetterberg.github.io/yubikey-gpg-nixos.html
{ config, pkgs, lib, ... }:

{
  programs.ssh.startAgent = false;

  services.pcscd.enable = true;

  # https://discourse.nixos.org/t/gpg-smartcard-for-ssh/33689
  hardware.gpgSmartcards.enable = true; # for yubikey

  environment.systemPackages = with pkgs; [
    gnupg
    yubikey-personalization
  ];

  environment.shellInit = ''
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

  services = {
    udev.packages = with pkgs; [
      yubikey-personalization
    ];
    gnome.gnome-keyring.enable = lib.mkForce false;
  };
}