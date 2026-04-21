{...}: {
  flake.modules.nixos.locale = {
    time.timeZone = "Europe/Berlin";
  };
}
