{self, ...}: {
  flake.nixosModules.zellij = {...}: {
    home-manager.users.slh = self.homeModules.zellij;
  };

  flake.homeModules.zellij = {...}: {
    catppuccin.zellij.enable = true;

    programs.zellij = {
      enable = true;

      settings = {
        default_layout = "compact";

        # Turn off borders around individual panes.
        pane_frames = false;

        # Native Wayland clipboard support
        copy_command = "wl-copy";

        show_startup_tips = false;
      };
    };
  };
}
