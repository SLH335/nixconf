{self, ...}: {
  flake.modules.nixos.apps = {
    home-manager.users.slh = self.modules.homeManager.apps;
  };

  flake.modules.homeManager.apps = {pkgs, ...}: {
    home.packages = with pkgs; [
      zathura
      grayjay
      gimp
    ];
  };
}
