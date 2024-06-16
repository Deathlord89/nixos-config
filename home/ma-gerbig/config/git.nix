{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;

    userName = "Marc-André Gerbig";
    userEmail = "marc.gerbig@gmail.com";
    signing.key = "39CB130C67B92382";
  };
}
