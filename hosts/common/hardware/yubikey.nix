# Reference:
# https://rzetterberg.github.io/yubikey-gpg-nixos.html
{pkgs, ...}: {
  programs.ssh.startAgent = false;

  # https://discourse.nixos.org/t/gpg-smartcard-for-ssh/33689
  hardware.gpgSmartcards.enable = true; # for yubikey

  environment.systemPackages = with pkgs; [yubikey-personalization];

  services = {
    pcscd.enable = true;
    udev.packages = with pkgs; [
      yubikey-personalization
    ];
  };
}
