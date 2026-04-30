{self, ...}: {
  flake.modules.nixos.devTools = {
    home-manager.users.slh = self.modules.homeManager.devTools;
  };

  flake.modules.homeManager.devTools = {pkgs, ...}: {
    home.packages = with pkgs; [
      cursor-cli
      claude-code
      typst
    ];
  };
}
