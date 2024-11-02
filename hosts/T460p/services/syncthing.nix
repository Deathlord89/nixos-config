{
  imports = [
    ../../common/optional/syncthing.nix
  ];

  services = {
    syncthing = {
      settings = {
        devices = {
          # Existing devices here!
          steamdeck.id = "IGM62YB-NUY5QXD-QRBBMQX-PFWSSZG-5NEN3ZQ-XH6CGWW-3DWS2TA-DMW77AG";
        };

        #folders = {
        #  "Default Folder" = {
        #    id = "default";
        #    path = "/home/ma-gerbig/Sync";
        #    devices = ["steamdeck"];
        #  };
        #};
      };
    };
  };
}
