{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.slh-pc = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.pcConfiguration
    ];
  };

  flake.hosts.slh-pc = {
    role = "desktop";
    addresses = ["slh-pc"];
    authorizesRoles = ["desktop"];

    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGTh343/neeYh/Cg5gz/YUaE+HdwVa7xqj2aJCxvp7FW root@slh-pc";

    userKeys.slh = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAINOutF/qx6HNk50Za3EQ1VO8nSIMN3zCXzlTA55F+V0/AAAABHNzaDo= slh@slh.dev";
  };
}
