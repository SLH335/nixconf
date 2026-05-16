{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.slh-apps = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.serverAppsConfiguration
    ];
  };

  flake.hosts.slh-apps = {
    role = "server";
    addresses = ["slh-apps"];

    # Desktops can SSH in; servers can't SSH back out (empty userKeys
    # below, plus no other host authorizes role="server").
    authorizesRoles = ["desktop"];
    userKeys = {};

    publicKey = "";
  };
}
