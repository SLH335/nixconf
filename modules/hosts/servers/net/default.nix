{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.slh-net = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.serverNetConfiguration
    ];
  };

  flake.hosts.slh-net = {
    role = "server";
    addresses = ["slh-net"];

    # Desktops can SSH in; servers can't SSH back out (empty userKeys
    # below, plus no other host authorizes role="server").
    authorizesRoles = ["desktop"];
    userKeys = {};

    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIInOjgVNlqKpaaaMz9fxLa08MGWjdk89SlsNct/t1tQJ root@networking";
  };
}
