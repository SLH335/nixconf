{self, ...}: {
  flake.modules.nixos.serverModules = {
    imports = with self.modules.nixos; [
      ### SYSTEM ###
      userSlh
      nix
      bootloader
      networking
      locale
      nh
      packages
      sshFleet
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
      # devTools

      ### GAMING ###
    ];
  };
}
