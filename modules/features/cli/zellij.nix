{self, ...}: {
  flake.nixosModules.zellij = {...}: {
    home-manager.users.slh = self.homeModules.zellij;
  };

  flake.homeModules.zellij = {...}: {
    programs.zellij = {
      enable = true;

      settings = {
        default_layout = "compact";

        # Turn off borders around individual panes.
        pane_frames = false;

        # Native Wayland clipboard support
        copy_command = "wl-copy";

        show_startup_tips = false;

        theme = "catppuccin-mocha";
        themes = {
          catppuccin-mocha = {
            bg = "#585b70";
            fg = "#cdd6f4";
            red = "#f38ba8";
            green = "#a6e3a1";
            blue = "#89b4fa";
            yellow = "#f9e2af";
            magenta = "#f5c2e7";
            orange = "#fab387";
            cyan = "#89dceb";
            black = "#1e1e2e";
            white = "#cdd6f4";
          };
        };
      };
    };
  };
}
