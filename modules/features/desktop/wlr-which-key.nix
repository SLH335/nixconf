{
  inputs,
  lib,
  ...
}: {
  flake.mkWhichKeyExe = pkgs: menu:
    lib.getExe (inputs.wrapper-modules.wrappers.wlr-which-key.wrap {
      inherit pkgs;
      settings = {
        inherit menu;

        font = "JetBrainsMono Nerd Font 12";

        # Catppuccin Mocha
        background = "#1e1e2e"; # base
        color = "#cdd6f4"; # text
        border = "#cba6f7"; # mauve

        separator = " ➜ ";
        border_width = 2;
        corner_r = 15;
        padding = 15;
        rows_per_column = 5;
        column_padding = 25;

        anchor = "bottom-right";
        margin_right = 0;
        margin_bottom = 5;
        margin_left = 5;
        margin_top = 0;
      };
    });
}
