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
          NAZGUL.id = "M7YFRFP-ST3RR2M-U6JV32F-RUHRVVQ-SMXSDQJ-YRWAB3B-VKEUHCB-NDCBJQ2";
          steamdeck.id = "IGM62YB-NUY5QXD-QRBBMQX-PFWSSZG-5NEN3ZQ-XH6CGWW-3DWS2TA-DMW77AG";
        };

        folders = {
          "Default Folder" = {
            id = "default";
            path = "/home/ma-gerbig/Sync";
            devices = [
              "Maximus"
              "NAZGUL"
              "steamdeck"
            ];
          };
        };
      };
    };
  };
}
