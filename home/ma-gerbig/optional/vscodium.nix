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
        "explorer.confirmDelete" = false;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableCommitSigning" = true;
        "nix.enableLanguageServer" = true;
      };
    };
  };
}
