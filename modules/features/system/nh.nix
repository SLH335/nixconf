{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.nh = {pkgs, ...}: {
    programs.nh = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.nh;

      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 10 --keep-since 14d";
      };
    };
  };

  perSystem = {pkgs, ...}: {
    packages.nh = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.nh;
      envDefault.NH_FLAKE = "/etc/nixos";
    };
  };
}
