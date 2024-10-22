{
  pkgs,
  config,
  lib,
  myLib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    #mutableUsers = false;
    users.ma-gerbig = {
      isNormalUser = true;
      description = "Marc-André Gerbig";
      extraGroups = ["wheel"] ++ ifTheyExist ["networkmanager"];

      #hashedPasswordFile = config.sops.secrets."password/ma-gerbig".path;
      openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/ma-gerbig/ssh.pub);
      packages = [pkgs.home-manager];
      shell = pkgs.fish;
    };
  };

  #sops.secrets."password/ma-gerbig".neededForUsers = true;

  home-manager = {
    users.ma-gerbig = import ../../../../home/ma-gerbig/${config.networking.hostName}.nix;
    extraSpecialArgs = {inherit myLib;};
  };
}
