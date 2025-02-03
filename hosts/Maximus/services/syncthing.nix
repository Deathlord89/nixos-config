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
          T460p.id = "7H7UMNA-IBPSUGV-7ZSSPAR-YSFK6H4-SMKVZD6-6N5ABIV-FYTQSFU-K5QRZAQ";
        };

        folders = {
          "Default Folder" = {
            id = "default";
            path = "/home/ma-gerbig/Sync";
            devices = [
              "steamdeck"
              "T460p"
            ];
          };
          "Farming Simulator 25 - Mods" = {
            id = "fs25_mods";
            path = "/var/lib/games/SteamLibrary/steamapps/compatdata/2300320/pfx/drive_c/users/steamuser/Documents/My Games/FarmingSimulator2025/mods";
            devices = [
              "steamdeck"
            ];
          };
        };
      };
    };
  };
}
