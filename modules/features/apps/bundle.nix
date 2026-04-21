{self, ...}: {
  flake.nixosModules.appsBundle = {
    imports = with self.nixosModules; [
      firefox
      imv
      mpv
    ];
  };
}
