{
  config,
  pkgs,
  ...
}: {
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      enter_accept = true;
      filter_mode_shell_up_key_binding = "host";
      auto_sync = true;
      sync_frequency = "30m";
      secrets_filter = true;
      records = true;
      daemon = {
        enabled = true;
        systemd_socket = true;
      };
    };
  };

  # Fix for bad zfs performance
  # https://forum.atuin.sh/t/getting-the-daemon-working-on-nixos/334/5
  systemd.user = let
    #atuinSockDir = "${config.home.homeDirectory}/.local/share/atuin";
    atuinSockDir = "/run/user/1000"; #Fix for Version 18.3.0

    atuinSock = "${atuinSockDir}/atuin.sock";
    unitConfig = {
      Description = "Atuin Magical Shell History Daemon";
      ConditionPathIsDirectory = atuinSockDir;
      ConditionPathExists = "${config.home.homeDirectory}/.config/atuin/config.toml";
    };
  in {
    sockets.atuin-daemon = {
      Unit = unitConfig;
      Install.WantedBy = ["default.target"];
      Socket = {
        ListenStream = atuinSock;
        Accept = false;
        SocketMode = "0600";
      };
    };
    services.atuin-daemon = {
      Unit = unitConfig;
      Service.ExecStart = "${pkgs.atuin}/bin/atuin daemon";
    };
  };
}
