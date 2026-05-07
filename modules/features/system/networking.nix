{...}: {
  flake.modules.nixos.networking = {
    networking.networkmanager.enable = true;

    services.tailscale.enable = true;
  };
}
