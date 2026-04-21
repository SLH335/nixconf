{self, ...}: {
  flake.nixosModules.devBundle = {
    imports = with self.nixosModules; [
      aws
      docker
      git
      java
      neovim
    ];
  };
}
