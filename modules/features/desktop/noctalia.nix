{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.noctalia = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.papirus-icon-theme
      self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia
    ];
  };

  perSystem = {pkgs, ...}: {
    packages.noctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings;
      env.QS_ICON_THEME = "Papirus";
    };
  };
}
