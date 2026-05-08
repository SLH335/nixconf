{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.nh = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.nh;
      envDefault.NH_FLAKE = "/etc/nixos";
    };
  };
}
