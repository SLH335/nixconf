{self, ...}: {
  flake.nixosModules.btop = {
    home-manager.users.slh = self.homeModules.btop;
  };

  flake.homeModules.btop = {
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
