{self, ...}: {
  flake.modules.nixos.niri = {pkgs, ...}: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };

    slh.userHomeModules.niri = self.modules.homeManager.niri;
  };

  flake.modules.homeManager.niri = {pkgs, ...}: {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };
}
