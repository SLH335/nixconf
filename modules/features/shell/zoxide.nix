{self, ...}: {
  flake.modules.nixos.zoxide = {config, ...}: {
    home-manager.users.${config.slh.primaryUser} = self.modules.homeManager.zoxide;
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
