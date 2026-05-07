{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.slh-home = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.server2Configuration
    ];
  };

  flake.hosts.slh-home = {
    role = "server";
    addresses = ["slh-home"];

    # Desktops can SSH in; servers can't SSH back out (empty userKeys
    # below, plus no other host authorizes role="server").
    authorizesRoles = ["desktop"];
    userKeys = {};

    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIILE0D5W+pC+6K/oKJCKoiHO8eTx0MqcDPhG+MlHAUPT root@slh-home";
  };
}
