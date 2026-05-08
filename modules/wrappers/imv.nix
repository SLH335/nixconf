{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.imv = inputs.wrapper-modules.wrappers.imv.wrap {
      inherit pkgs;
      settings = {
        options = {
          fullscreen = false;
          # Disable the bottom text overlay for ultimate minimalism
          overlay = false;
          # Catppuccin Mocha — inlined here so HM doesn't need
          # programs.imv just for the color theme. When color management is
          # reworked, lift these into a shared theme expression.
          background = "1e1e2e";
          overlay_text_color = "cdd6f4";
          overlay_background_color = "11111b";
        };
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
  };
}
