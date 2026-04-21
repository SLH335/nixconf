{self, ...}: {
  flake.nixosModules.gamingBundle = {
    imports = with self.nixosModules; [
      steam
    ];
  };
}
