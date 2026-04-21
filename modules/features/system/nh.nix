{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.nh = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.nh];
  };

  perSystem = {pkgs, ...}: {
    packages.nh = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.nh;
      envDefault.NH_FLAKE = "/etc/nixos";
    };
  };
}
