# nixos-config

find /dev/disk/by-id/


cd /tmp

curl https://raw.githubusercontent.com/Deathlord89/nixos-config/main/hosts/T460p/disko.nix -o /tmp/disko.nix

nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix


nix-shell -p git

nixos-install --root /mnt --flake "https://github.com/Deathlord89/nixos-config/archive/master.tar.gz#$HOST"


if something fail: nix-collect-garbage, export TMPDIR=/tmp


cd /

umount -Rl /mnt

zpool export -a

nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'



Sometimes gpg refuses my yubikey gpg key. This will fix it:
'echo "test" | gpg --clearsign'