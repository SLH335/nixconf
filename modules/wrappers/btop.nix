{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.btop = inputs.wrapper-modules.wrappers.btop.wrap {
      inherit pkgs;
      settings = {
        color_theme = "catppuccin_mocha";
        theme_background = false;
        update_ms = 500;
        vim_keys = true;
        rounded_corners = true;
        show_coretemp = true;
        cpu_single_core = false;
      };
      # The wrapper's `themes` option accepts either a path (a single file
      # at /nix/store/<hash>-name) or raw lines. The catppuccin btop theme
      # lives at <drv>/catppuccin_mocha.theme — a *subpath* of a store dir,
      # so it doesn't satisfy `lib.isStorePath` and would be written as
      # literal content otherwise. readFile inlines the content instead.
      themes.catppuccin_mocha = builtins.readFile "${inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system}.btop}/catppuccin_mocha.theme";
    };
  };
}
