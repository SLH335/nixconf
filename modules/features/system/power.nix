{...}: {
  flake.nixosModules.power = {
    services.upower.enable = true;
  };
}
