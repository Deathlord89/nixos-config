{
  inputs,
  config,
  pkgs,
  pkgs-unstable,
  ...
}: let
  inherit (inputs) home-manager;
in {
  imports = [
    home-manager.nixosModules.home-manager
  ];
  home-manager = {
    users = {
      ma-gerbig = import ../home/ma-gerbig;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    #extraSpecialArgs = {
    #  inherit pkgs-unstable;
    #};
  };
}
