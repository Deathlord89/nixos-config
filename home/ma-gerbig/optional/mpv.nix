{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      profile = "high-quality";
      # Specify high quality video rendering preset (for --vo=<gpu|gpu-next> only)
      # Offers superior image fidelity and visual quality for an enhanced viewing
      # experience on capable hardware

      vo = "gpu"; # Just use the GPU.
      gpu-api = "vulkan"; # Use vulkan instead of D3D11
      hwdec = "auto-safe"; # Uses best hardware decoder.
    };
    scripts = with pkgs.mpvScripts; [
      inhibit-gnome
      mpris
      quality-menu
      thumbfast
      uosc
    ];
  };
}
