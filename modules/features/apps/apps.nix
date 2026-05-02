{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.apps = {
    home-manager.users.slh = self.modules.homeManager.apps;
  };

  flake.modules.homeManager.apps = {pkgs, ...}: {
    home.packages = with pkgs; [
      zathura
      grayjay
      gimp
      libqalculate
      picard
      inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
