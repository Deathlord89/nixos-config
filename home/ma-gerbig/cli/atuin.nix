{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      enter_accept = true;
      filter_mode_shell_up_key_binding = "host";
      records = true;
    };
  };
}
