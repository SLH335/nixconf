{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    catppuccinThemeFile = "${inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system}.yazi}/mocha/catppuccin-mocha-lavender.toml";
  in {
    packages.yazi = inputs.wrapper-modules.wrappers.yazi.wrap {
      inherit pkgs;
      settings = {
        yazi = {
          mgr = {
            show_hidden = true;
            sort_by = "natural";
            sort_dir_first = true;
            sort_reverse = false;
            linemode = "size";
            show_symlink = true;
            ratio = [1 4 3];
          };
          preview = {
            max_width = 1000;
            max_height = 1000;
            image_filter = "lanczos3";
            image_quality = 90;
          };
        };
        keymap.mgr.prepend_keymap = [
          {
            run = "close";
            on = ["<C-q>"];
            desc = "Close Yazi";
          }
          {
            run = "plugin smart-enter";
            on = ["l"];
            desc = "Enter the child directory, or open the file";
          }
          {
            run = "plugin smart-enter";
            on = ["<Enter>"];
            desc = "Enter the child directory, or open the file";
          }
        ];
        # Catppuccin theme inlined from the catppuccin/yazi flake. See
        # the wrappers note in modules/wrappers/btop.nix for the rationale
        # (no HM-side catppuccin needed once theme lives in the wrapper).
        theme = builtins.fromTOML (builtins.readFile catppuccinThemeFile);
      };
      plugins = {
        full-border = pkgs.yaziPlugins.full-border;
        smart-enter = pkgs.yaziPlugins.smart-enter;
      };
      # init.lua isn't a first-class wrapper option; add it via constructFiles
      # so full-border:setup() runs at yazi startup.
      constructFiles."init.lua" = {
        relPath = "yazi-config/init.lua";
        content = ''require("full-border"):setup()'';
      };
      # Tools yazi shells out to for previews. Bundling them via
      # extraPackages keeps the user's shell PATH free of preview-only
      # binaries while making yazi self-contained.
      extraPackages = with pkgs; [
        ffmpegthumbnailer
        p7zip
        jq
        poppler-utils
        fd
        ripgrep
        fzf
        exiftool
      ];
    };
  };
}
