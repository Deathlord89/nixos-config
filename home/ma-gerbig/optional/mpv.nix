{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      # https://iamscum.wordpress.com/guides/videoplayback-guide/mpv-conf/

      # Profile
      profile = "high-quality"; # Specify high quality video rendering preset

      # General
      cursor-autohide = "100";
      autocreate-playlist = "same";

      # OSD
      osd-bar = "no"; # Recommended for uosc
      border = "no"; # Recommended for uosc

      # Priority
      alang = "jpn,ger,eng";
      slang = "ger,eng,enm";

      # Video
      vo = "gpu-next"; # Use experimental GPU renderer.
      #gpu-api = "vulkan"; # Use vulkan instead of D3D11
      hwdec = "auto"; # Uses best available hardware decoder.
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
