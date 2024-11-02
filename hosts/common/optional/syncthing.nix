{config, ...}: {
  services = {
    syncthing = {
      enable = true;
      openDefaultPorts = true;
      user = "ma-gerbig";
      dataDir = "/home/ma-gerbig"; # Default folder for new synced folders, instead of /var/lib/syncthing
      configDir = "/home/ma-gerbig/.config/syncthing"; # Folder for Syncthing's settings and keys. Will be overwritten by Nix!
      overrideDevices = true; # overrides any devices added or deleted through the WebUI
      overrideFolders = true; # overrides any folders added or deleted through the WebUI
      key = config.sops.secrets.syncthing_key.path;
      cert = config.sops.secrets.syncthing_cert.path;
    };
  };

  sops.secrets = {
    syncthing_key = {
      sopsFile = ../../${config.networking.hostName}/secrets.yaml;
      owner = "ma-gerbig";
      mode = "0440";
    };
    syncthing_cert = {
      sopsFile = ../../${config.networking.hostName}/secrets.yaml;
      owner = "ma-gerbig";
      mode = "0440";
    };
  };
}
