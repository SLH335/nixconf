{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.slh-server = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.serverConfiguration
    ];
  };
}
