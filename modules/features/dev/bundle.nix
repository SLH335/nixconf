{self, ...}: {
  flake.modules.nixos.devBundle = {
    imports = with self.modules.nixos; [
      aws
      direnv
      docker
      git
      neovim
      squeak
      devTools
    ];
  };
}
