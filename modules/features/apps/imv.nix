{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.imv = {...}: {
    home-manager.users.slh = self.modules.homeManager.imv;
  };

  flake.modules.homeManager.imv = {...}: {
    catppuccin.imv.enable = true;

    programs.imv = {
      enable = true;

      settings = {
        options = {
          fullscreen = false;
          # Disable the bottom text overlay for ultimate minimalism
          overlay = false;
        };

        # Bind Vim keys for navigation and panning
        binds = {
          # Image navigation
          l = "next";
          h = "prev";

          # Panning (when zoomed in)
          j = "pan 0 -50";
          k = "pan 0 50";

          # Zooming
          i = "zoom 1";
          o = "zoom -1";

          # Quick close
          q = "quit";
          "<Escape>" = "quit";
        };
      };
    };

    xdg.mimeApps = {
      defaultApplications = {
        # Route all common image types to imv
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
