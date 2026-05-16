{...}: {
  flake.modules.nixos.docker = {
    pkgs,
    config,
    ...
  }: {
    virtualisation.docker = {
      enable = true;
      storageDriver = "btrfs";
    };

    networking.firewall.allowedTCPPorts = [2377 7946];
    networking.firewall.allowedUDPPorts = [7946 4789];

    users.users.${config.slh.primaryUser}.extraGroups = ["docker"];
  };
}
