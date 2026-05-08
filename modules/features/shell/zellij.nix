{self, ...}: {
  flake.modules.nixos.zellij = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.zellij
    ];
  };
}
