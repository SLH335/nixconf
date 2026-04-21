{self, ...}: {
  flake.modules.nixos.shellBundle = {
    imports = with self.modules.nixos; [
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
