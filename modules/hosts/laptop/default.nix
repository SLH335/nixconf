{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.slh-laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.laptopConfiguration
    ];
  };
}
