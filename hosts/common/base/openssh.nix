{
  services = {
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no"; # disable root login
        PasswordAuthentication = false; # disable password login
      };
    };
  };
}
