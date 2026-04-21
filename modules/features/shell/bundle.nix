{self, ...}: {
  flake.nixosModules.shellBundle = {
    imports = with self.nixosModules; [
      atuin
      btop
      cli
      ghostty
      shell
      yazi
      zellij
      zoxide
    ];
  };
}
