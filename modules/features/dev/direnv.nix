{self, ...}: {
  flake.modules.nixos.direnv = {
    home-manager.users.slh = self.modules.homeManager.direnv;
  };

  flake.modules.homeManager.direnv = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
