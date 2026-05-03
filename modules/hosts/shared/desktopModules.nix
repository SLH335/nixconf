{self, ...}: {
  flake.modules.nixos.desktopModules = {
    imports = with self.modules.nixos; [
      ### SYSTEM ###
      primaryUser
      nix
      bootloader
      networking
      user
      home
      audio
      locale
      keyring
      nh
      packages
      openrgb

      ### SHELL ###
      zsh
      cli
      atuin
      btop
      yazi
      zellij
      zoxide

      ### DESKTOP ###
      greetd
      niri
      noctalia
      shikane
      theme
      wayland

      ### APPS ###
      apps
      firefox
      ghostty
      imv
      mpv

      ### DEV ###
      neovim
      git
      direnv
      docker
      devTools
      dev-work
      squeak

      ### GAMING ###
      steam
    ];
  };
}
