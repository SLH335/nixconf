{...}: {
  flake.nixosModules.docker = {pkgs, ...}: {
    virtualisation.docker = {
      enable = true;
      storageDriver = "btrfs";
    };

    users.users.slh.extraGroups = ["docker"];
  };
}
