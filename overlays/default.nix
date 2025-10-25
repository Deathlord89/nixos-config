# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = _final: prev: {
    # Disable ssh-agent from gnome-keyring
    # https://discourse.nixos.org/t/disable-ssh-agent-from-gnome-keyring-on-gnome/28176
    #gnome-keyring = prev.gnome-keyring.overrideAttrs (oldAttrs: {
    #  mesonFlags =
    #    (builtins.filter (flag: flag != "-Dssh-agent=true") oldAttrs.mesonFlags)
    #    ++ [
    #      "-Dssh-agent=false"
    #    ];
    #});

    # https://wiki.nixos.org/wiki/NixOS_on_ARM/Raspberry_Pi_4
    libcec = prev.libcec.override {withLibraspberrypi = true;};
  };

  # When applied, the stable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.stable.packagename'
  stable-packages = final: _prev: rec {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
      overlays = [(_final: _prev: {})];
    };
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable.packagename'
  unstable-packages = final: _prev: rec {
    unstable = import inputs.nixpkgs {
      inherit (final) system;
      config.allowUnfree = true;
      overlays = [(_final: _prev: {})];
    };
  };
}
