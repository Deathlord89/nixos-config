{
  imports = [
    ../../common/optional/syncthing.nix
  ];

  services = {
    syncthing = {
      settings = {
        devices = {
          # Existing devices here!
          NitroX.id = "4WNOAB3-IS6D344-VDWQTSU-OPGJT65-7XC3OIH-Q63QAS4-OVRV4OJ-ZXLZWAE";
          steamdeck.id = "IGM62YB-NUY5QXD-QRBBMQX-PFWSSZG-5NEN3ZQ-XH6CGWW-3DWS2TA-DMW77AG";
          T460p.id = "7H7UMNA-IBPSUGV-7ZSSPAR-YSFK6H4-SMKVZD6-6N5ABIV-FYTQSFU-K5QRZAQ";
        };

        folders = {
          "Default Folder" = {
            id = "default";
            path = "/home/ma-gerbig/Sync";
            devices = [
              "NitroX"
              "steamdeck"
              "T460p"
            ];
          };

          "Elder Scrolls Online - AddOns" = {
            id = "eso_addons";
            path = "/home/ma-gerbig/syncthing/eso_addons";
            type = "receiveonly";
            devices = [
              "NitroX"
              "steamdeck"
            ];
          };
          "Elder Scrolls Online - SavedVariables" = {
            id = "eso_saved";
            path = "/home/ma-gerbig/syncthing/eso_saved";
            type = "receiveonly";
            devices = [
              "NitroX"
              "steamdeck"
            ];
          };

          "Farming Simulator 25 - Mods" = {
            id = "fs25_mods";
            path = "/home/ma-gerbig/syncthing/fs25_mods";
            type = "receiveonly";
            devices = [
              "NitroX"
              "steamdeck"
            ];
          };
        };
      };
    };
  };
}
