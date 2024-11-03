{
  pkgs,
  config,
  lib,
  myLib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users = {
    mutableUsers = false;
    users.ma-gerbig = {
      isNormalUser = true;
      shell = pkgs.fish;
      description = "Marc-André Gerbig";
      extraGroups =
        [
          "wheel"
          "users"
        ]
        ++ ifTheyExist [
          "audio"
          "gamemode"
          "libvirtd"
          "networkmanager"
          "video"
        ];

      hashedPasswordFile = config.sops.secrets."password/ma-gerbig".path;
      openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/ma-gerbig/ssh.pub);
      packages = [pkgs.home-manager];
    };
  };

  sops.secrets."password/ma-gerbig".neededForUsers = true;

  home-manager = {
    users.ma-gerbig = import ../../../../home/ma-gerbig/${config.networking.hostName}.nix;
    extraSpecialArgs = {inherit myLib;};
  };
}
