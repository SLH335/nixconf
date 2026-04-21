{self, ...}: {
  flake.modules.nixos.appsBundle = {
    imports = with self.modules.nixos; [
      firefox
      imv
      mpv
    ];
  };
}
