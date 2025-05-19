{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        jnoortheen.nix-ide
        kamadorueda.alejandra
        mkhl.direnv
        ms-ceintl.vscode-language-pack-de
        naumovs.color-highlight
        shd101wyy.markdown-preview-enhanced
      ];
      userSettings = {
        "direnv.restart.automatic" = true; # Automatically restart direnv if .envrc changes
        "explorer.confirmDelete" = false;
        "git.autofetch" = true; # Periodically fetch from remotes
        "git.confirmSync" = false; # Do not ask for confirmation when syncing
        "git.enableCommitSigning" = true;
        "nix.enableLanguageServer" = true;
      };
    };
  };

  home.packages = with pkgs; [
    # Nix IDE
    nil
  ];
}
