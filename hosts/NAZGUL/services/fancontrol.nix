{
  services = {
    hddfancontrol = {
      enable = true;
      extraArgs = [
        #"--drive-temp-range=40:70 --min-fan-speed-prct=10 --interval=1min"
        "--min-fan-speed-prct=10"
        "--interval=1min"
        #"--max-temp=70"
        #"--drive-temp-range=70"
      ];
      disks = [
        "/dev/disk/by-id/ata-WDC_WD60EFRX-68L0BN1_WD-WXL1H16LX5XX"
        "/dev/disk/by-id/ata-WDC_WD60EFRX-68L0BN1_WD-WXB1HB4VCJU3"
        "/dev/disk/by-id/ata-WDC_WD60EFPX-68C5ZN0_WD-WX42D344E417"
        "/dev/disk/by-id/ata-WDC_WD60EFPX-68C5ZN0_WD-WX22D345SXSE"
        "/dev/disk/by-id/ata-WDC_WD60EFPX-68C5ZN0_WD-WX52D64NC34N"
      ];
      pwmPaths = ["/sys/class/hwmon/hwmon1/pwm2:160:64"];
    };
  };
}
