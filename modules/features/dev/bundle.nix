{self, ...}: {
  flake.modules.nixos.devBundle = {
    imports = with self.modules.nixos; [
      aws
      docker
      git
      neovim
      squeak
      devTools
    ];
  };
}
