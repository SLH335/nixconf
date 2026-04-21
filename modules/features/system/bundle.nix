{self, ...}: {
  flake.modules.nixos.systemBundle = {
    imports = with self.modules.nixos; [
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
