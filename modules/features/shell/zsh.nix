{self, ...}: {
  flake.modules.nixos.zsh = {
    programs.zsh.enable = true;

    slh.userHomeModules.zsh = self.modules.homeManager.zsh;
  };

  flake.modules.homeManager.zsh = {
    pkgs,
    config,
    ...
  }: {
    catppuccin.starship.enable = true;
    catppuccin.zsh-syntax-highlighting.enable = true;

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

        aws = {
          disabled = true;
        };
      };
    };
  };
}
