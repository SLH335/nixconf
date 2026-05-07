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

    # TODO: capture on this host with `cat /etc/ssh/ssh_host_ed25519_key.pub`
    publicKey = null;

    # TODO: paste from `cat ~/.ssh/id_ed25519_sk.pub` (Nitrokey)
    # userKeys.slh = "sk-ssh-ed25519@openssh.com AAAA...";
  };
}
