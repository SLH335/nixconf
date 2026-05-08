{self, ...}: {
  flake.modules.nixos.mpv = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.mpv
    ];

    # mpv-as-default for video MIME types. Lives in HM because
    # xdg.mimeApps writes to ~/.config/mimeapps.list which is per-user
    # state — nothing the wrapper can express.
    slh.userHomeModules.mpv = {...}: {
      xdg.mimeApps.defaultApplications = {
        "video/mp4" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop"; # .mkv
        "video/webm" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop"; # .mov
        "video/x-flv" = "mpv.desktop";
        "video/x-msvideo" = "mpv.desktop"; # .avi
      };
    };
  };
}
