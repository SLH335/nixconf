{self, ...}: {
  flake.modules.nixos.gamingBundle = {
    imports = with self.modules.nixos; [
      steam
    ];
  };
}
