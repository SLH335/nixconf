{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.slh-pc = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.pcConfiguration
    ];
  };
}
