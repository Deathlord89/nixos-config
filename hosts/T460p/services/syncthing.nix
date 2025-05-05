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
          NitroX.id = "4WNOAB3-IS6D344-VDWQTSU-OPGJT65-7XC3OIH-Q63QAS4-OVRV4OJ-ZXLZWAE";
          steamdeck.id = "IGM62YB-NUY5QXD-QRBBMQX-PFWSSZG-5NEN3ZQ-XH6CGWW-3DWS2TA-DMW77AG";
        };

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
