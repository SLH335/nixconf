{self, ...}: {
  flake.modules.nixos.isoConfiguration = {modulesPath, ...}: {
    # installation-cd-minimal.nix already provides bootloader, the
    # nixos user with autologin, basic networking, locale, and base
    # packages. Don't import system-level modules that conflict with
    # those defaults (bootloader, networking, locale, etc.). Don't
    # import serverModules either: imports must be unique paths
    # through the module graph, or flake-module dedup fails (nvf).
    #
    # userIso supplies the slh.primaryUser = "nixos" binding so
    # feature modules' userHomeModules entries (if/when ISO opts in
    # to a home-manager-bearing user module) target the right account.
    # Today userIso is home-manager-free: the live overlayfs has been
    # known to drop home-manager-nixos.service into emergency on boot.
    imports = [
      "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"

      ### SYSTEM ###
      self.modules.nixos.userIso

      ### SHELL ###
      # self.modules.nixos.zsh
      # self.modules.nixos.cli
      # self.modules.nixos.atuin
      # self.modules.nixos.btop
      # self.modules.nixos.yazi
      # self.modules.nixos.zellij
      # self.modules.nixos.zoxide

      ### DESKTOP ###
      # self.modules.nixos.theme

      ### DEV ###
      self.modules.nixos.neovim
      # self.modules.nixos.git
    ];

    networking.hostName = "slh-nixos";

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    # system.stateVersion = "25.05";
  };
}
