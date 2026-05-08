{self, ...}: {
  flake.modules.nixos.nh = {pkgs, ...}: {
    programs.nh = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.nh;

      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 10 --keep-since 30d";
      };
    };
  };
}
