{self, ...}: {
  flake.modules.nixos.direnv = {config, ...}: {
    home-manager.users.${config.slh.primaryUser} = self.modules.homeManager.direnv;
  };

  flake.modules.homeManager.direnv = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
