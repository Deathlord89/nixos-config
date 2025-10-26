{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    (import ./disks.nix {inherit lib;})

    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t460p

    ../common/hardware/nvidia
    ../common/hardware/nvidia/optimus.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
