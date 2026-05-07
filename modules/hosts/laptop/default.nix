{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.slh-laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.laptopConfiguration
    ];
  };

  flake.hosts.slh-laptop = {
    role = "desktop";
    addresses = ["slh-laptop"];
    authorizesRoles = ["desktop"];

    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFfhquVvnvr7KPsk3qyf/WCjgO5qMZzlBHUmvi4c3B4h root@slh-laptop";
    userKeys.slh = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIOYpOpVqkkH4ggKrowAumvkKqHvGD25R8kP7VRl3uneuAAAABHNzaDo= slh@slh.dev";
  };
}
