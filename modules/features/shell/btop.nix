{self, ...}: {
  flake.modules.nixos.btop = {
    home-manager.users.slh = self.modules.homeManager.btop;
  };

  flake.modules.homeManager.btop = {
    catppuccin.btop.enable = true;

    programs.btop = {
      enable = true;

      settings = {
        theme_background = false; # fix opacity

        update_ms = 500;

        vim_keys = true;

        rounded_corners = true;

        show_coretemp = true;
        cpu_single_core = false;
      };
    };
  };
}
