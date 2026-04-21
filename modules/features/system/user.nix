{...}: {
  flake.nixosModules.user = {pkgs, ...}: {
    users.users.slh = {
      isNormalUser = true;
      description = "SLH";
      extraGroups = ["wheel" "networkmanager" "input"];
      shell = pkgs.zsh;
      home = "/home/slh";
    };
  };
}
