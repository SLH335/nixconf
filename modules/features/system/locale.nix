{...}: {
  flake.nixosModules.locale = {
    time.timeZone = "Europe/Berlin";
  };
}
