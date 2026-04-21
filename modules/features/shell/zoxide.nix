{self, ...}: {
  flake.modules.nixos.zoxide = {...}: {
    home-manager.users.slh = self.modules.homeManager.zoxide;
  };

  flake.modules.homeManager.zoxide = {...}: {
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
