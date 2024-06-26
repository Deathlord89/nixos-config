{
  # Systemd-Boot bootloader configuration
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      timeout = 1;
    };

    # Quiet boot with plymouth - supports LUKS passphrase entry if needed
    kernelParams = [
      "quiet"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "boot.shell_on_fail"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
    plymouth.enable = true;
  };
}
