{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.theme = {
    imports = [
      inputs.catppuccin.nixosModules.catppuccin
    ];

    catppuccin = {
      flavor = "mocha";
      accent = "lavender";
    };

    catppuccin.tty.enable = true;

    home-manager.users.slh = self.homeModules.theme;
  };

  flake.homeModules.theme = {
    imports = [
      inputs.catppuccin.homeModules.catppuccin
    ];

    catppuccin = {
      flavor = "mocha";
      accent = "lavender";
    };
  };
}
