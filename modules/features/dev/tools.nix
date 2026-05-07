{self, ...}: {
  flake.modules.nixos.devTools = {
    slh.userHomeModules.devTools = self.modules.homeManager.devTools;
  };

  flake.modules.homeManager.devTools = {pkgs, ...}: {
    home.packages = with pkgs; [
      cursor-cli
      claude-code
      typst
    ];
  };
}
