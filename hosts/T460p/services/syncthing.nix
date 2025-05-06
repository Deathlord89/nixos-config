{
  imports = [
    ../../common/optional/syncthing.nix
  ];

  services = {
    syncthing = {
      settings = {
        folders = {
          "Default Folder" = {
            id = "default";
            path = "/home/ma-gerbig/Sync";
            devices = [
              "NAZGUL"
              "NitroX"
              "steamdeck"
            ];
          };
        };
      };
    };
  };
}
