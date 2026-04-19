{self, ...}: {
  flake.nixosModules.atuin = {...}: {
    home-manager.users.slh = self.homeModules.atuin;
  };

  flake.homeModules.atuin = {...}: {
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
