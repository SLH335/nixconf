{inputs, ...}: {
  flake.nixosModules.neovim = {...}: {
    imports = [
      inputs.nvf.nixosModules.default
    ];

    programs.nvf = {
      enable = true;

      settings.vim = {
        #################################################
        # Core editor options
        #################################################

        viAlias = true;
        vimAlias = true;

        options = {
          number = true;
          relativenumber = true;
          shiftwidth = 2;
          tabstop = 2;
          expandtab = true;
          smartindent = true;
          wrap = false;
        };

        ### KEYMAPS ###
        keymaps = [
          {
            key = "<leader>y";
            mode = "n";
            action = "\"+y";
            desc = "Yank to system clipboard";
          }
          {
            key = "<leader>y";
            mode = "v";
            action = "\"+y";
            desc = "Yank selection to system clipboard";
          }
          {
            key = "<leader>d";
            mode = "n";
            action = "\"+d";
            desc = "Cut to system clipboard";
          }
          {
            key = "<leader>d";
            mode = "v";
            action = "\"+d";
            desc = "Cut selection to system clipboard";
          }
          {
            key = "<C-h>";
            mode = "n";
            action = "<C-w>h";
            desc = "Move to left window";
          }
          {
            key = "<C-j>";
            mode = "n";
            action = "<C-w>j";
            desc = "Move to lower window";
          }
          {
            key = "<C-k>";
            mode = "n";
            action = "<C-w>k";
            desc = "Move to upper window";
          }
          {
            key = "<C-l>";
            mode = "n";
            action = "<C-w>l";
            desc = "Move to right window";
          }
          {
            key = "]d";
            mode = "n";
            action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
            desc = "Next diagnostic";
          }
          {
            key = "[d";
            mode = "n";
            action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
            desc = "Previous diagnostic";
          }
          # {
          #   key = "<leader>e";
          #   mode = "n";
          #   action = "<cmd>lua vim.diagnostic.open_float()<CR>";
          #   desc = "Show diagnostic";
          # }
          {
            key = "<leader>u";
            mode = "n";
            action = "<cmd>UndotreeToggle<CR>";
            desc = "Toggle Undo Tree";
          }
        ];

        #################################################
        # Theme / UI
        #################################################

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };

        statusline.lualine = {
          enable = true;
        };

        visuals = {
          rainbow-delimiters.enable = true;
          indent-blankline.enable = true;
          fidget-nvim.enable = true;
          highlight-undo.enable = true;
        };

        ui = {
          # Replaces the bottom command line with sleek floating windows
          noice.enable = true;
          # Applies rounded borders to all floating windows globally
          borders.enable = true;
          # Highlights colors (e.g. hex-codes)
          # colorizer.enable = true;
        };

        # Adds startup screen when opening nvim without a file
        dashboard.alpha.enable = true;
        hideSearchHighlight = true;

        #################################################
        # Completion
        #################################################

        autocomplete.nvim-cmp = {
          enable = true;

          sources = {
            buffer = null;
          };

          mappings = {
            complete = "<C-Space>";
            confirm = "<C-y>";

            next = "<C-j>";
            previous = "<C-k>";

            scrollDocsUp = "<C-u>";
            scrollDocsDown = "<C-d>";
          };
        };

        #################################################
        # Treesitter
        #################################################

        treesitter = {
          enable = true;
          fold = false;
        };

        #################################################
        # Git integration
        #################################################

        git = {
          enable = true;
          gitsigns.enable = true;
        };

        #################################################
        # Telescope + other stuff
        #################################################

        telescope.enable = true;
        binds.whichKey.enable = true;
        navigation.harpoon.enable = true;

        #################################################
        # Editing utilities
        #################################################

        autopairs.nvim-autopairs.enable = true;
        comments.comment-nvim.enable = true;
        notes.todo-comments.enable = true;

        utility = {
          undotree.enable = true;
          yazi-nvim = {
            enable = true;
            setupOpts.open_for_directories = true;
          };
        };

        #################################################
        # Language support
        #################################################

        lsp = {
          enable = true;

          # Shows function signatures as you type
          lspSignature.enable = true;
          # Adds a dedicated window for listing all project errors
          trouble.enable = true;
          # Support for embedded languages (markdown, etc.)
          otter-nvim.enable = true;

          formatOnSave = true;
        };
        languages = {
          enableTreesitter = true;
          # Automatically configures conform.nvim to format on save
          enableFormat = true;

          # Nix
          nix = {
            enable = true;

            lsp = {
              enable = true;
              servers = ["nil"];
            };

            treesitter.enable = true;
          };

          # Go
          go.enable = true;

          # Python
          python.enable = true;

          # Typescript / React
          ts = {
            enable = true;
          };

          json.enable = true;
        };
        formatter.conform-nvim.enable = true;
      };
    };
  };
}
