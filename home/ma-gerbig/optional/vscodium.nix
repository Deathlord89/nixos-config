{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      jnoortheen.nix-ide
      kamadorueda.alejandra
      mkhl.direnv
      ms-ceintl.vscode-language-pack-de
      shd101wyy.markdown-preview-enhanced
    ];
    userSettings = {
      "editor.fontFamily" = "'JetBrainsMono Nerd Font Mono', 'Droid Sans Mono', 'monospace', monospace";
      "explorer.confirmDelete" = false;
      "git.autofetch" = true;
      "git.confirmSync" = false;
      "git.enableCommitSigning" = true;
      "nix.enableLanguageServer" = true;
    };
  };
}
