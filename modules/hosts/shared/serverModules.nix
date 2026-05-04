{self, ...}: {
  flake.modules.nixos.serverModules = {
    imports = with self.modules.nixos; [
      ### SYSTEM ###
      primaryUser
      nix
      bootloader
      networking
      user
      home
      locale
      nh
      packages
      sshServer

      ### SHELL ###
      zsh
      cli
      atuin
      btop
      yazi
      zellij
      zoxide

      ### DESKTOP ###
      theme

      ### APPS ###
      ghostty

      ### DEV ###
      neovim
      git
      direnv
      docker
      devTools

      ### GAMING ###
    ];
  };
}
