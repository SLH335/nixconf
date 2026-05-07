{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.theme = {
    imports = [
      inputs.catppuccin.nixosModules.catppuccin
    ];

    catppuccin = {
      flavor = "mocha";
      accent = "lavender";
    };

    catppuccin.tty.enable = true;

    slh.userHomeModules.theme = self.modules.homeManager.theme;
  };

  flake.modules.homeManager.theme = {
    imports = [
      inputs.catppuccin.homeModules.catppuccin
    ];

    catppuccin = {
      flavor = "mocha";
      accent = "lavender";
    };
  };
}
