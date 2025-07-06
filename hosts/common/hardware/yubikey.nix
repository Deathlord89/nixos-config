# Reference:
# https://rzetterberg.github.io/yubikey-gpg-nixos.html
{
  lib,
  pkgs,
  ...
}: {
  programs.ssh.startAgent = lib.mkForce false;

  # https://discourse.nixos.org/t/gpg-smartcard-for-ssh/33689
  hardware.gpgSmartcards.enable = true; # for yubikey

  environment.systemPackages = with pkgs; [yubikey-personalization];

  services = {
    gnome.gcr-ssh-agent.enable = lib.mkForce false;
    pcscd.enable = true;
    udev.packages = with pkgs; [
      yubikey-personalization
    ];
  };
}
