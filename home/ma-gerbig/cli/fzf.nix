{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    #defaultCommand=;
    #defaultOptions = [];
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = ["--preview='bat --color=always -n {}'"];
    changeDirWidgetCommand = "fd --type d --exclude .git --follow --hidden";
    changeDirWidgetOptions = ["--preview 'tree -C {} | head -200'"];
  };
}
