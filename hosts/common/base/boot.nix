{
  # Systemd-Boot bootloader configuration
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      timeout = 1;
    };

    consoleLogLevel = 0;
    initrd.verbose = false;
  };
}
