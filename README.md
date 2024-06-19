# nixos-config

find /dev/disk/by-id/

nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko disko.nix

nix-shell -p git

nixos-install --root /mnt --flake "https://github.com/Deathlord89/nixos-config/archive/master.tar.gz#$HOST"

if somethink fail: nix-collect-garbage, export TMPDIR=/tmp

cd /
umount -Rl /mnt
zpool export -a
