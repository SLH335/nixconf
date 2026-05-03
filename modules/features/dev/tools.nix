{self, ...}: {
  flake.modules.nixos.devTools = {config, ...}: {
    home-manager.users.${config.slh.primaryUser} = self.modules.homeManager.devTools;
  };

  flake.modules.homeManager.devTools = {pkgs, ...}: {
    home.packages = with pkgs; [
      cursor-cli
      claude-code
      typst
    ];
  };
}
