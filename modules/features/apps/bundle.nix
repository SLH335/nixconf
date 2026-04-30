{self, ...}: {
  flake.modules.nixos.appsBundle = {
    imports = with self.modules.nixos; [
      apps
      firefox
      imv
      mpv
    ];
  };
}
