{inputs, ...}: {
  imports = [inputs.chaotic.nixosModules.default];

  chaotic.nyx = {
    # Chaotic-Nyx's binary cache is defined in flake.nix
    cache.enable = false;
    # Add Chaotic-Nyx's overlay to system's pkgs
    overlay.enable = true;
  };
}
