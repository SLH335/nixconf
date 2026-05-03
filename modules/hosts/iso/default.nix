{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.slh-iso = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.modules.nixos.isoConfiguration
    ];
  };
}
