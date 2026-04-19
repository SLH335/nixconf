{self, ...}: {
  flake.nixosModules.shell = {...}: {
    programs.zsh.enable = true;

    home-manager.users.slh = self.homeModules.shell;
  };

  flake.homeModules.shell = {
    pkgs,
    config,
    ...
  }: {
    programs.zsh = {
      enable = true;

      autocd = true;

      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;

      # Home Manager natively handles history variables, eliminating manual exports
      history = {
        size = 10000;
        save = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
        # path = "/home/slh/.local/share/zsh/history";
        share = true;
        ignoreSpace = true;
      };

      # Plugins injected securely from Nixpkgs
      # This replaces sourcing hardcoded /usr/share paths
      plugins = [
        {
          name = "zsh-vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];

      initContent = ''
        function zvm_after_init() {
          # Bind Ctrl+R in both normal (vicmd) and insert (viins) Vi modes
          zvm_bindkey viins '^R' _atuin_search_widget
          zvm_bindkey vicmd '^R' _atuin_search_widget

          # Map Ctrl+L to clear the screen in all Vi modes
          zvm_bindkey viins '^L' clear-screen
          zvm_bindkey vicmd '^L' clear-screen
          zvm_bindkey visual '^L' clear-screen
        }
      '';
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        add_newline = false;
        format = "$directory$character";
        palette = "catppuccin_mocha";
        right_format = "$all";

        line_break = {
          disabled = true;
        };

        package = {
          disabled = true;
        };

        golang = {
          symbol = " ";
        };

        git_branch = {
          format = "[$symbol$branch(:$remote_branch)]($style) ";
        };

        palettes = {
          catppuccin_mocha = {
            rosewater = "#f5e0dc";
            flamingo = "#f2cdcd";
            pink = "#f5c2e7";
            mauve = "#cba6f7";
            red = "#f38ba8";
            maroon = "#eba0ac";
            peach = "#fab387";
            yellow = "#f9e2af";
            green = "#a6e3a1";
            teal = "#94e2d5";
            sky = "#89dceb";
            sapphire = "#74c7ec";
            blue = "#89b4fa";
            lavender = "#b4befe";
            text = "#cdd6f4";
            subtext1 = "#bac2de";
            subtext0 = "#a6adc8";
            overlay2 = "#9399b2";
            overlay1 = "#7f849c";
            overlay0 = "#6c7086";
            surface2 = "#585b70";
            surface1 = "#45475a";
            surface0 = "#313244";
            base = "#1e1e2e";
            mantle = "#181825";
            crust = "#11111b";
          };
        };
      };
    };
  };
}
