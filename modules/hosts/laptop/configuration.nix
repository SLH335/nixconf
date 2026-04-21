{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.laptopConfiguration = {...}: {
    imports = [
      self.nixosModules.laptopHardwareConfiguration

      self.nixosModules.systemBundle
      self.nixosModules.desktopBundle
      self.nixosModules.shellBundle
      self.nixosModules.appsBundle
      self.nixosModules.devBundle
      self.nixosModules.gamingBundle
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
