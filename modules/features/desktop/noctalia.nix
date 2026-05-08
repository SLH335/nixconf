{self, ...}: {
  flake.modules.nixos.noctalia = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.papirus-icon-theme
      self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia
    ];
  };
}
