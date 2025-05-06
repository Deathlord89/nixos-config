{
  imports = [
    ../../common/optional/syncthing.nix
  ];

  services = {
    syncthing = {
      settings = {
        devices = {
          # Existing devices here!
          NAZGUL.id = "M7YFRFP-ST3RR2M-U6JV32F-RUHRVVQ-SMXSDQJ-YRWAB3B-VKEUHCB-NDCBJQ2";
          steamdeck.id = "IGM62YB-NUY5QXD-QRBBMQX-PFWSSZG-5NEN3ZQ-XH6CGWW-3DWS2TA-DMW77AG";
          T460p.id = "7H7UMNA-IBPSUGV-7ZSSPAR-YSFK6H4-SMKVZD6-6N5ABIV-FYTQSFU-K5QRZAQ";
        };

        folders = {
          "Default Folder" = {
            id = "default";
            path = "/home/ma-gerbig/Sync";
            devices = [
              "NAZGUL"
              "steamdeck"
              "T460p"
            ];
          };

          "Elder Scrolls Online - AddOns" = {
            id = "eso_addons";
            path = "/home/ma-gerbig/.steam/steam/steamapps/compatdata/306130/pfx/drive_c/users/steamuser/Documents/Elder Scrolls Online/live/AddOns";
            devices = [
              "NAZGUL"
              "steamdeck"
            ];
          };
          "Elder Scrolls Online - SavedVariables" = {
            id = "eso_saved";
            path = "/home/ma-gerbig/.steam/steam/steamapps/compatdata/306130/pfx/drive_c/users/steamuser/Documents/Elder Scrolls Online/live/SavedVariables";
            devices = [
              "NAZGUL"
              "steamdeck"
            ];
          };

          "Farming Simulator 25 - Mods" = {
            id = "fs25_mods";
            path = "/home/ma-gerbig/.steam/steam/steamapps/compatdata/2300320/pfx/drive_c/users/steamuser/Documents/My Games/FarmingSimulator2025/mods";
            devices = [
              "NAZGUL"
              "steamdeck"
            ];
          };
        };
      };
    };
  };
}
