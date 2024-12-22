{lib, ...}: {
  boot = {
    plymouth.enable = lib.mkForce false;
    initrd.network = {
      # This will use udhcp to get an ip address.
      enable = true;
      udhcpc.enable = true;
      ssh = {
        enable = true;
        # To prevent ssh clients from freaking out because a different host key is used,
        # a different port for ssh is useful (assuming the same host has also a regular sshd running)
        port = 2222;
        # hostKeys paths must be unquoted strings, otherwise you'll run into issues with boot.initrd.secrets
        # the keys are copied to initrd from the path specified; multiple keys can be set
        # you can generate any number of host keys using
        # `ssh-keygen -t ed25519 -N "" -f /path/to/ssh_host_ed25519_key`
        hostKeys = ["/etc/ssh/ssh_host_rsa_key" "/etc/ssh/ssh_host_ed25519_key"];
        # public ssh key used for login
        authorizedKeys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6FVd+Px8j7uzieIYbNW9LdqqGH4oyzYldt3CTaGxs2vJdp2qhxNUGPpRLUY8gPe9cmlRHplaocWNiMFdBfpqGmtT36gTfw8L3CboyeTP4xSX01oUcKFxBly0D4np2QDtBq9soXwi5Er33FDpZl15DovDOOOXh+j3ClcWEjLlJqLGmSu6P9egk5sza1SUl1yrXQuNgxHRh90/Y9mTTxKoZwpAsopx8ant6F3JVgzN2y03sETNa/uwzKSftUlFecSEZJ4AB7qgFUf1T9u3ZtlF2VwzW552cstp6BcrDZJqotDKKK8UoL7S+lrjpZSAG5orEavZNF1SG3zzpx+b+yOryZn4kFuvOiYpND97z4J4bN5NKUWf1vLNy7LLOurfrIN+wnrvsySbumoibs3M04J9XTMxNaI2ipkMc8H/DmzsF7yaqEfxMXdeeVeS62oPWFRKtbi8sI+49e6Rej/8ob+c5RauCpsmPi5WIWgvIgLQXo7YExzoQ/s/SibYKcWfkQyPFMznVV/tx2R6GRcradKER9EaP37tMd26h8djZDtnELo6woOdBDjDNhSWq88+CznFo9JIk3/iQudJ18lftPy8cVL1ZwjfoNPHEDf3BgCrZc/aWC+A2imZMTs24JTkzEom2gq6IvTRePJzNEsRXBpigv1gENSEhylavuSjMTR6Zew== cardno:14 322 693"];
      };
      postCommands = ''
        # Import all pools
        zpool import -a
        # Add the load-key command to the .profile
        echo "zfs load-key -a; killall zfs" >> /root/.profile
      '';
    };
  };
}
