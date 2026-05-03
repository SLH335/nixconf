{...}: {
  flake.modules.nixos.user = {
    pkgs,
    config,
    ...
  }: {
    users.users.${config.slh.primaryUser} = {
      isNormalUser = true;
      description = "SLH";
      extraGroups = ["wheel" "networkmanager" "input"];
      shell = pkgs.zsh;
      # home defaults to /home/<name>; no need to set it explicitly.
    };
  };
}
