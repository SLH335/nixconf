{self, ...}: {
  flake.modules.nixos.direnv = {
    slh.userHomeModules.direnv = self.modules.homeManager.direnv;
  };

  flake.modules.homeManager.direnv = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
