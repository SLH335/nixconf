{self, ...}: {
  flake.modules.nixos.laptopConfiguration = {...}: {
    imports = [
      self.modules.nixos.laptopHardwareConfiguration

      self.modules.nixos.desktopModules

      self.modules.nixos.bluetooth
      self.modules.nixos.power
      self.modules.nixos.howdy
    ];

    networking.hostName = "slh-laptop";

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "25.05";
  };
}
