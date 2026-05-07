{self, ...}: {
  flake.modules.nixos.atuin = {
    slh.userHomeModules.atuin = self.modules.homeManager.atuin;
  };

  flake.modules.homeManager.atuin = {...}: {
    catppuccin.atuin.enable = true;

    programs.atuin = {
      enable = true;
      enableZshIntegration = true;

      flags = [
        "--disable-up-arrow"
      ];

      settings = {
        style = "compact";
        inline_height = 10;

        search_mode = "fuzzy";

        auto_sync = false;
        update_check = false;
      };
    };
  };
}
