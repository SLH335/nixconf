{self, ...}: {
  flake.nixosModules.yazi = {...}: {
    home-manager.users.slh = self.homeModules.yazi;
  };

  flake.homeModules.yazi = {pkgs, ...}: {
    # Install optional tools Yazi relies on for rich previews
    home.packages = with pkgs; [
      ffmpegthumbnailer # Video thumbnails
      p7zip # Archive extraction and previews
      jq # JSON previews
      poppler-utils # PDF previews
      fd # Fast file searching
      ripgrep # Fast file content searching
      fzf # Fuzzy finding
    ];

    programs.yazi = {
      enable = true;

      enableZshIntegration = true;

      # This explicitly assigns the wrapper alias to 'y'.
      # Launching Yazi with 'y' will ensure that when you quit, your terminal
      # changes its directory to wherever you left off in Yazi!
      shellWrapperName = "y";

      # Sensible UI and behavior defaults
      settings = {
        manager = {
          show_hidden = true;
          sort_by = "natural";
          sort_dir_first = true;
          sort_reverse = false;
          linemode = "size";
          show_symlink = true;
          ratio = [1 4 3]; # Panel width ratios: parent, current, preview
        };
        preview = {
          max_width = 1000;
          max_height = 1000;
          image_filter = "lanczos3";
          image_quality = 90;
        };
      };

      # Declaratively inject official Yazi plugins from Nixpkgs
      plugins = {
        full-border = pkgs.yaziPlugins.full-border;
        smart-enter = pkgs.yaziPlugins.smart-enter;
      };

      # Initialize the Lua plugins that require it
      initLua = ''
        require("full-border"):setup()
      '';

      # Keybindings
      keymap = {
        manager.prepend_keymap = [
          # Easy escape
          {
            run = "close";
            on = ["<C-q>"];
            desc = "Close Yazi";
          }

          # Smart enter (plugin) - open file or enter dir with single key
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
      };
    };
  };
}
