# Notes on reinstalling NixOS

Find out the hard disk ID with `find /dev/disk/by-id/`. This is needed if the [disko](https://github.com/nix-community/disko) config file must be edited.

## Installation of an already configured machine
* Set the hostname of the machine as ENV variable `export HOST=xyz`.

* Download the disk declaration from github as /tmp/disko.nix directory: `curl https://raw.githubusercontent.com/Deathlord89/nixos-config/main/hosts/$HOST/disko.nix -o /tmp/disko.nix`

`nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix`

`nix-shell -p git`

`nixos-install --root /mnt --flake "https://github.com/Deathlord89/nixos-config/archive/master.tar.gz#$HOST"`


```
cd /
umount -Rl /mnt
zpool export -a
```
`nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'`

## Troubleshooting
* If something fail `nix-collect-garbage`, check the config and reinstall
* For compiling packages like the nvidia proprietary driver you can override the installer temp directory with: `export TMPDIR=/tmp`
* Sometimes gnupg refuses my yubikey gpg key. This will fix it: `echo "test" | gpg --clearsign`
