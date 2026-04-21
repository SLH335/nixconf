{self, ...}: {
  flake.nixosModules.systemBundle = {
    imports = with self.nixosModules; [
      audio
      bluetooth
      bootloader
      home
      keyring
      locale
      networking
      nh
      nix
      packages
      power
      user
    ];
  };
}
