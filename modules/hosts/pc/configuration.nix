{self, ...}: {
  flake.modules.nixos.pcConfiguration = {...}: {
    imports = [
      self.modules.nixos.pcHardwareConfiguration

      self.modules.nixos.systemBundle
      self.modules.nixos.desktopBundle
      self.modules.nixos.shellBundle
      self.modules.nixos.appsBundle
      self.modules.nixos.devBundle
      self.modules.nixos.gamingBundle
    ];

    networking.hostName = "slh-pc";

    services.greetd.settings.initial_session = {
      command = "niri-session";
      user = "slh";
    };

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
