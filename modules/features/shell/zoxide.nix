{self, ...}: {
  flake.nixosModules.zoxide = {...}: {
    home-manager.users.slh = self.homeModules.zoxide;
  };

  flake.homeModules.zoxide = {...}: {
    programs.zoxide = {
      enable = true;

      # Automatically hook into ZSH setup
      enableZshIntegration = true;

      # Replace cd with zoxide
      options = [
        "--cmd cd"
      ];
    };
  };
}
