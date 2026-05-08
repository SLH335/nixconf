{self, ...}: {
  flake.modules.nixos.imv = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.imv
    ];

    slh.userHomeModules.imv = {...}: {
      # imv-as-default for image MIME types. Stays in HM for the same
      # reason as mpv (per-user mimeapps.list state).
      xdg.mimeApps.defaultApplications = {
        "image/jpeg" = "imv.desktop";
        "image/png" = "imv.desktop";
        "image/gif" = "imv.desktop";
        "image/webp" = "imv.desktop";
        "image/svg+xml" = "imv.desktop";
        "image/bmp" = "imv.desktop";
        "image/jxl" = "imv.desktop";
      };
    };
  };
}
