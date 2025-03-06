{
  imports = [
    ../../common/optional/syncthing.nix
  ];

  services = {
    syncthing = {
      settings = {
        devices = {
          # Existing devices here!
          Maximus.id = "FM3Q33R-NTLIUEM-LWEIQJV-GAJHS4X-CXMPCF4-KVGSCIK-BDLDOQJ-5HUX5QD";
          steamdeck.id = "IGM62YB-NUY5QXD-QRBBMQX-PFWSSZG-5NEN3ZQ-XH6CGWW-3DWS2TA-DMW77AG";
          T460p.id = "7H7UMNA-IBPSUGV-7ZSSPAR-YSFK6H4-SMKVZD6-6N5ABIV-FYTQSFU-K5QRZAQ";
        };

        folders = {
          "Default Folder" = {
            id = "default";
            path = "/home/ma-gerbig/Sync";
            devices = [
              "Maximus"
              "steamdeck"
              "T460p"
            ];
          };

          "Elder Scrolls Online - AddOns" = {
            id = "eso_addons";
            path = "/home/ma-gerbig/syncthing/eso_addons";
            type = "receiveonly";
            devices = [
              "Maximus"
              "steamdeck"
            ];
          };
          "Elder Scrolls Online - SavedVariables" = {
            id = "eso_saved";
            path = "/home/ma-gerbig/syncthing/eso_saved";
            type = "receiveonly";
            devices = [
              "Maximus"
              "steamdeck"
            ];
          };

          "Farming Simulator 25 - Mods" = {
            id = "fs25_mods";
            path = "/home/ma-gerbig/syncthing/fs25_mods";
            type = "receiveonly";
            devices = [
              "Maximus"
              "steamdeck"
            ];
          };
        };
      };
    };
  };
}
