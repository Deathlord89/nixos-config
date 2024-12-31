{pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAliases = {
      cat = "bat";
    };
    plugins = [
      {
        name = "autopair";
        inherit (pkgs.fishPlugins.autopair) src;
      }
      {
        name = "fzf-fish";
        inherit (pkgs.fishPlugins.fzf-fish) src;
      }
      {
        name = "puffer";
        inherit (pkgs.fishPlugins.puffer) src;
      }
    ];
  };
}
