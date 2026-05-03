{self, ...}: {
  flake.modules.nixos.zellij = {config, ...}: {
    home-manager.users.${config.slh.primaryUser} = self.modules.homeManager.zellij;
  };

  flake.modules.homeManager.zellij = {...}: {
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
