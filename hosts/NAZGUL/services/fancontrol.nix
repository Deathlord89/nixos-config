{
  services = {
    hddfancontrol = {
      enable = true;
      smartctl = true;
      extraArgs = [
        "--pwm-start-value=160"
        "--pwm-stop-value=64"
        "--min-fan-speed-prct=10"
        "--interval=60"
        "--max-temp=70"
      ];
      disks = [
        "/dev/disk/by-id/ata-WDC_WD60EFRX-68L0BN1_WD-WXL1H16LX5XX"
        "/dev/disk/by-id/ata-WDC_WD60EFRX-68L0BN1_WD-WXB1HB4VCJU3"
        "/dev/disk/by-id/ata-WDC_WD60EFPX-68C5ZN0_WD-WX42D344E417"
        "/dev/disk/by-id/ata-WDC_WD60EFPX-68C5ZN0_WD-WX22D345SXSE"
        "/dev/disk/by-id/ata-WDC_WD60EFPX-68C5ZN0_WD-WX52D64NC34N"
      ];
      pwmPaths = ["/sys/class/hwmon/hwmon2/pwm2"];
    };
  };
}
