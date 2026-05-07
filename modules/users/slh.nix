{
  self,
  lib,
  inputs,
  ...
}: {
  flake.modules.nixos.userSlh = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      self.modules.nixos.primaryUser
      self.modules.nixos.userHomeModules
      inputs.home-manager.nixosModules.default
    ];

    slh.primaryUser = lib.mkDefault "slh";

    users.users.slh = {
      isNormalUser = true;
      description = "SLH";
      extraGroups = ["wheel" "networkmanager" "input"];
      shell = pkgs.zsh;
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.slh = {
        imports = lib.attrValues config.slh.userHomeModules;
        home.stateVersion = "25.11";
        programs.home-manager.enable = true;
      };
    };
  };
}
