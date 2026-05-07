{
  self,
  lib,
  ...
}: {
  flake.modules.nixos.userIso = {pkgs, ...}: {
    imports = [
      self.modules.nixos.primaryUser
      self.modules.nixos.userHomeModules
    ];

    slh.primaryUser = lib.mkDefault "nixos";

    users.users.nixos.shell = pkgs.zsh;
    programs.zsh.enable = true;
  };
}
