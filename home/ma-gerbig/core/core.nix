{pkgs, ...}: {
  home.packages = with pkgs; [
    ncdu # analyzer your disk usage Interactively, via TUI(replacement of `du`)
    doggo # DNS client for humans
    fd # search for files by name, faster than find
    fzf # Interactively filter its input using fuzzy searching, not limit to filenames.
    gping # ping, but with a graph(TUI)
    just # a command runner like make, but simpler
    ripgrep # search for files by its content, replacement of grep
    lazygit # Git terminal UI

    # Nix related
    nix-output-monitor # with more details log output
    nvd #Nix/NixOS package version diff tool
  ];

  programs = {
    # List contents of directory
    eza = {
      enable = true;
      enableFishIntegration = true;
      git = true;
      icons = true;
      extraOptions = [
        "--header"
      ];
    };

    bat = {
      enable = true;
      config = {
      };
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    #atuin = {
    #  enable = true;
    #  enableBashIntegration = true;
    #  enableFishIntegration = true;
    #};
  };
}
