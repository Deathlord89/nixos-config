{
  hostname,
  lib,
  myLib,
  outputs,
  ...
}: {
  imports = myLib.scanPaths ./. ++ (builtins.attrValues outputs.nixosModules);

  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
  };
}
