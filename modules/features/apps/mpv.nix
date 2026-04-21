{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.mpv = {
    home-manager.users.slh = self.modules.homeManager.mpv;
  };

  flake.modules.homeManager.mpv = {
    catppuccin.mpv.enable = true;

    programs.mpv = {
      enable = true;

      # MPV Configuration (mpv.conf)
      config = {
        # Modern high-quality video rendering
        profile = "gpu-hq";
        vo = "gpu-next";

        # Force Wayland natively
        gpu-context = "wayland";

        # Enable hardware decoding for smooth playback and low CPU usage
        hwdec = "auto-safe";

        # Don't close the window instantly when the video finishes playing
        keep-open = "yes";

        # Remove the default clunky UI (useful if you want to use modern
        # third-party OSCs like 'uosc', or just want it completely minimal)
        # osc = "no";

        # Save video position on quit
        save-position-on-quit = "yes";
      };

      profiles = {
        "dont-save-at-end" = {
          # This condition becomes true the exact millisecond the video finishes
          profile-cond = "eof_reached";

          # Override the global setting so it doesn't write to the history file
          save-position-on-quit = "no";
        };
      };

      # Custom Keybindings (input.conf)
      bindings = {
        # Vim-style seeking and volume control
        "h" = "seek -5";
        "l" = "seek 5";
        "j" = "add volume -2";
        "k" = "add volume 2";

        # Shift variants for larger jumps
        "H" = "seek -60";
        "L" = "seek 60";

        # Quick quit
        "q" = "quit";
        "<Escape>" = "quit";

        # Toggle fullscreen
        "f" = "cycle fullscreen";
      };
    };

    xdg.mimeApps.defaultApplications = {
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop"; # .mkv files
      "video/webm" = "mpv.desktop";
      "video/quicktime" = "mpv.desktop"; # .mov files
      "video/x-flv" = "mpv.desktop";
      "video/x-msvideo" = "mpv.desktop"; # .avi files
    };
  };
}
