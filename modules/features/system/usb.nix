{self, ...}: {
  flake.modules.nixos.usb = {
    services.udisks2.enable = true;

    slh.userHomeModules.usb = self.modules.homeManager.usb;
  };

  flake.modules.homeManager.usb = {
    lib,
    pkgs,
    ...
  }: {
    services.udiskie = {
      enable = true;
      settings = {
        # workaround for
        # https://github.com/nix-community/home-manager/issues/632
        program_options = {
          file_manager = "${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.ghostty} -e ${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.yazi}";
        };
      };
    };
  };
}
