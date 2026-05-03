{self, ...}: {
  flake.modules.nixos.isoConfiguration = {modulesPath, ...}: {
    # installation-cd-minimal.nix already provides bootloader, nixos
    # user with autologin, basic networking, locale, base packages.
    # Don't import system-level modules (bootloader, user, networking,
    # locale, etc.) — they conflict with the ISO defaults. Don't import
    # serverModules here either: imports must be unique paths through
    # the module graph, or flake-module dedup fails (nvf, etc.).
    imports = [
      "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"

      ### SYSTEM ###
      # primaryUser exposes the slh.primaryUser option (set below to
      # "nixos" to retarget all home-manager bindings); home wires up
      # home-manager-as-NixOS-module so those bindings actually apply.
      self.modules.nixos.primaryUser
      # `home` disabled on the ISO: home-manager-nixos.service is
      # wantedBy multi-user.target, and if activation fails on the
      # live overlayfs (write quirks, no XDG_RUNTIME_DIR before login,
      # etc.) systemd drops to emergency / a recovery shell. Re-enable
      # if/when the ISO needs home-manager.
      # self.modules.nixos.home

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
    # nixpkgs.hostPlatform = "x86_64-linux";

    # Retarget all home-manager.users.<n> bindings from the default
    # "slh" to the auto-created "nixos" user on the live ISO.
    slh.primaryUser = "nixos";

    # Copy the entire squashfs into a tmpfs at stage 1, then unmount
    # the original medium. Required when booting via Ventoy: the
    # virtual loop device Ventoy presents triggers SquashFS read
    # errors at runtime ("unable to read fragment cache entry"),
    # which corrupts /sysroot during switch_root and drops to a
    # recovery shell. The official minimal ISO doesn't hit this just
    # because it's small enough to read cleanly. Trade-off: the ISO
    # contents must fit in RAM (~1-3 GB depending on what's bundled).
    boot.kernelParams = ["copytoram"];

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
