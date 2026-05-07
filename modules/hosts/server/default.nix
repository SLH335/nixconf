{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.slh-server = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.serverConfiguration
    ];
  };

  flake.hosts.slh-server = {
    role = "server";
    addresses = ["slh-server"];

    # Desktops can SSH in; servers can't SSH back out (empty userKeys
    # below, plus no other host authorizes role="server").
    authorizesRoles = ["desktop"];
    userKeys = {};

    # TODO: capture on this host with `cat /etc/ssh/ssh_host_ed25519_key.pub`
    publicKey = null;
  };
}
