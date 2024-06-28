# This file defines overlays
{inputs, ...}: {
  flake-inputs = final: _: {
    inputs =
      builtins.mapAttrs (
        _: flake: let
          legacyPackages = (flake.legacyPackages or {}).${final.system} or {};
          packages = (flake.packages or {}).${final.system} or {};
        in
          if legacyPackages != {}
          then legacyPackages
          else packages
      )
      inputs;
  };

  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # Disable ssh-agent from gnome-keyring
    # https://discourse.nixos.org/t/disable-ssh-agent-from-gnome-keyring-on-gnome/28176
    gnome = prev.gnome.overrideScope' (gfinal: gprev: {
      gnome-keyring = gprev.gnome-keyring.overrideAttrs (oldAttrs: {
        configureFlags =
          oldAttrs.configureFlags
          or []
          ++ ["--disable-ssh-agent"];
      });
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
