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

    users.users.${config.slh.primaryUser}.extraGroups = ["docker"];
  };
}
